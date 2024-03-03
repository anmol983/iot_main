import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iotdustbin/Home/homepage.dart';
import 'package:iotdustbin/constants/constants.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  login() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      email.value = emailController.text;
      password.value = passwordController.text;
      var url = apiUrl + 'api/login/';
      try {
        var response = await http.post(Uri.parse(url), body: {
          'username': email.value,
          'email': email.value,
          'password': password.value,
        });
        print(response.body);
        if (response.statusCode == 200) {
          GetStorage().write('token', jsonDecode(response.body)['token']);
          Get.off(() => HomePage());
        }
      } catch (e) {
        print(e);
      }
      // Get.offAllNamed('/home');
    } else {
      Get.snackbar(
        'Error',
        'Please enter your email and password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
