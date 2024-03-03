import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iotdustbin/Auth/screens/login.dart';
import 'package:iotdustbin/Home/controllers/binsController.dart';
import 'package:iotdustbin/Home/detailbin.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    BinsController binsController = Get.put(BinsController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            ElevatedButton(
              onPressed: () {
                GetStorage().erase();
                Get.off(() => LoginPage());
              },
              child: const Text('Logout'),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Card(
            //     // child: ,
            //     )
            Obx(() {
              // if (binsController.isLoading.value) {
              //   return const Center(child: CircularProgressIndicator());
              // } else {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: binsController.binData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Get.to(() => BinDetail(
                            binId: binsController.binData[index]['bin_id'],
                          )),
                      child: Card(
                        child: ListTile(
                          title: Text(binsController.binData[index]['bin_id']
                              .toString()),
                          subtitle:
                              Text(binsController.binData[index]['location']),
                        ),
                      ),
                    );
                  });
              // }
            }),
          ],
        ));
  }
}
