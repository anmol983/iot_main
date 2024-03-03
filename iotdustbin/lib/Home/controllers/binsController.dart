import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iotdustbin/constants/constants.dart';
import 'package:http/http.dart' as http;

class BinsController extends GetxController {
  var bins = [].obs;
  var isLoading = true.obs;
  var binData = [].obs;
  TextEditingController binIp = TextEditingController();
  @override
  Future onInit() async {
    await fetchBins();
    await fetchBinData();
    super.onInit();
  }

  var user_id = ''.obs;
  fetchBins() async {
    isLoading(true);
    var url = apiUrl + 'api/a/list/';
    var response = await http.get(Uri.parse(url),
        headers: {'Authorization': 'Token ${GetStorage().read('token')}'});
    bins.value = jsonDecode(response.body);
    user_id.value = bins[0]['user_id'].toString();
    print(user_id);
    print(bins);
    // isLoading(false);
  }

  fetchBinData() async {
    var url = apiUrl + 'api/bin/list/${user_id.value}';
    var response = await http.get(Uri.parse(url),
        headers: {'Authorization': 'Token ${GetStorage().read('token')}'});
    binData.value = jsonDecode(response.body);
    print(response.body);
    print(response.statusCode);
  }

  addBin() async {
    var url = apiUrl + 'api/bin/';
    var response = await http.post(Uri.parse(url), body: {
      'user_id': user_id.value,
      'ip': binIp.text,
      'moisture': 0,
      'filled': 0
    }, headers: {
      'Authorization': 'Token ${GetStorage().read('token')}'
    });
    print(response.body);
  }
}
