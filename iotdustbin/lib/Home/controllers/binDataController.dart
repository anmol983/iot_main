import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iotdustbin/constants/constants.dart';
import 'package:http/http.dart' as http;

class BinDataController extends GetxController {
  int? binId;
  BinDataController(int this.binId);
  var binMoisture = 0.obs;
  var binFilled = 0.obs;
  @override
  Future onInit() async {
    super.onInit();
    await fetchBinData();
  }

  fetchBinData() async {
    var url = apiUrl + 'api/bin/$binId';
    var response = await http.get(Uri.parse(url),
        headers: {'Authorization': 'Token ${GetStorage().read('token')}'});
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      binMoisture.value = jsonDecode(response.body)['moisture'];
      binFilled.value = int.parse(jsonDecode(response.body)['filled']);
      // if (binFilled.value > 80) {
      //   // await callMqtt();
      // }
    } else {
      Get.snackbar('Error', 'Error fetching data');
    }
  }
  // callMqtt(){

  // }
}
