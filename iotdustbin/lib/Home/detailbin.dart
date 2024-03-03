import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iotdustbin/Home/controllers/binDataController.dart';

class BinDetail extends StatelessWidget {
  int? binId;
  BinDetail({super.key, this.binId});
  // BinDetail(int this.binId);

  @override
  Widget build(BuildContext context) {
    BinDataController binDataController = Get.put(BinDataController(binId!));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bin Detail'),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Obx(() => Text(
              'Bin ID: ${binDataController.binId}',
              style: TextStyle(fontSize: 20),
            )),
        Obx(
          () => Icon(
            Icons.delete,
            size: 100,
            color: binDataController.binFilled.value > 50
                ? Colors.orange
                : Colors.green,
            fill: binDataController.binFilled.value / 100,
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => Container(
                    height: binDataController.binFilled.value.toDouble() / 100,
                    color: binDataController.binFilled.value > 50
                        ? Colors.orange
                        : Colors.green,
                  ),
                ),
                Text('Filled: ${binDataController.binFilled.value}%')
              ],
            ),
            SizedBox(
              width: 50,
            ),
            Column(
              children: [
                Obx(
                  () => Container(
                    height:
                        binDataController.binMoisture.value.toDouble() / 100,
                    color: binDataController.binMoisture.value > 50
                        ? Colors.orange
                        : Colors.green,
                  ),
                ),
                Text('Bin Moisture: ${binDataController.binMoisture.value}%')
              ],
            )
            // Text(
            //   'Bin ID: ',
            //   style: TextStyle(fontSize: 20),
            // ),
            // Text(
            //   '1',
            //   style: TextStyle(fontSize: 20),
            // ),
          ],
          // ),
        )
      ]),
    );
  }
}
