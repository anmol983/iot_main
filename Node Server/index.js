const express = require("express");
const ws = require("ws");
const axios = require("axios");
const dotenv = require("dotenv");
const mqtt = require("mqtt");
const mqttClient = mqtt.connect("mqtt://broker.hivemq.com:1883");
const topic = "pradh/out";
const app = express();

const cors = require("cors");
const { type } = require("os");
const corsOptions = {
  origin: "*",
  credentials: true,
  optionSuccessStatus: 200,
};
app.use(cors(corsOptions));

const appWs = require("express-ws")(app);

//this snippet gets the local ip of the node.js server. copy this ip to the client side code
require("dns").lookup(require("os").hostname(), function (err, add, fam) {
  console.log("addr: " + add);
});

app.use(express.json());

const accountSid = "ACf7237916e9b36c2055108a33c6ace238";
const authToken = "df2b1dd9c54876abc21997b72a35637a";
const client = require("twilio")(accountSid, authToken);

// app.get("/send", (req, res) => {
//   const bin_ip = req.body.bin_ip;
//   client.messages
//     .create({
//       body: `Your Dustbin with Bin_ip ${bin_ip} is almost FULL!`,
//       from: "+15677043016",
//       to: "+918978655562",
//     })
//     .then((message) => console.log(message.sid));
//   client.messages
//     .create({
//       body: `Your Dustbin with Bin_ip ${bin_ip} is almost FULL!`,
//       from: "whatsapp:+14155238886",
//       to: "whatsapp:+918770641875",
//     })
//     .then((message) => console.log(message.sid));
// });

const apiAdd = "192.168.144.120"
const addData = async (moisture,ultraSonic) => {
  try {
    const newData = {
      bin_ip : "2",
      moisture : moisture,
      ultraSonic,
      user_id : null,
      filled : 10,
      location : "Mumbai"
    }
    console.log(newData)
    const config = {
      headers: {

        "Authorization": "Token a70ef94704c079495b6e57534ab44af5a3d2552dab1d781c91b230cf345d643f"
      }
    }
    const data = await axios.post(
      `http://${apiAdd}:8000/api/bin/`, newData, config
    );

  } catch (error) {
    console.log(error)
  }
}
const push_data = async (client, moisture, ultraSonic) => {
  try {
    const data = await axios.get(
      `http://${apiAdd}:8000/api/bin/ip/?bin_ip=${client}`
    );

    if (data.status === 200 && ultraSonic >= 0) {
      const newdata = {
        bin_id: data.data[0].bin_id,
        bin_ip: client,
        moisture: moisture,
        filled: ultraSonic,
        user_id: data.data[0].user_id,
      };
      const nData = JSON.stringify(newdata);
      console.log(newdata);
      console.log(nData);
      await axios.put(
        `http://${apiAdd}:8000/api/bin/${data.data[0].bin_id}`,
        newdata
      );
    }
  } catch (err) {
    console.log(err);
  }
};

mqttClient.on("connect", async () => {
  console.log("mqtt connected");
  mqttClient.subscribe(topic);
});

mqttClient.on("message", async (topic, msg) => {
  // const client = ws._socket.remoteAddress
  const buffer = Buffer.from(msg.buffer);

  // Now you can use the buffer as needed
  console.log(buffer.toString().substring(13));
  const data = buffer.toString().substring(13).split(";");
  console.log(data)
  const ultraSonic = data[0];
  const moisture = (data[1]);
  console.log(`recieved from client ${client}: ${moisture} and ${ultraSonic}`);

  const newData = {
    bin_id: 8,
    bin_ip: client,
    moisture: moisture,
    // ""
    filled: ultraSonic,
    user_id: null,
  };
  const nData = JSON.stringify(newData);
  console.log(nData);

  addData(moisture,ultraSonic)
  // push_data(client, moisture, ultraSonic);
});

app.listen(process.env.PORT || 8000, () => {
  console.log("Server started...");
});
