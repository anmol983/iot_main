import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:iotdustbin/Home/homepage.dart';
import 'package:iotdustbin/constants/constants.dart';

class RegistrationContorller extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phNo = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController zip = TextEditingController();
  var token = ''.obs;
  final box = GetStorage();
  register() async {
    var url = apiUrl + 'api/register/';
    if (!emailController.text.contains('@')) {
      Get.snackbar(
        'Error',
        'Please enter a valid email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (passwordController.text.length < 8) {
      Get.snackbar(
        'Error',
        'Password must be atleast 8 characters long',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        phNo.text.isNotEmpty &&
        address.text.isNotEmpty &&
        name.text.isNotEmpty &&
        state.text.isNotEmpty &&
        zip.text.isNotEmpty) {
      var response = await http.post(Uri.parse(url), body: {
        'username': emailController.text,
        'email': emailController.text,
        'password': passwordController.text,
      });
      token.value = jsonDecode(response.body)['token'];
      box.write('token', token.value);
      print(response.body);
    } else {
      Get.snackbar(
        'Error',
        'Please enter your email and password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
  }

  a() async {
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        phNo.text.isNotEmpty &&
        address.text.isNotEmpty &&
        name.text.isNotEmpty &&
        state.text.isNotEmpty &&
        zip.text.isNotEmpty &&
        !token.isEmpty) {
      var url = apiUrl + 'api/a/';
      print(phNo.text);
      var response = await http.post(Uri.parse(url), body: {
        'email': emailController.text,
        'password': passwordController.text,
        'phNo': phNo.text.toString(),
        'address': address.text,
        'name': name.text,
        'state': state.text,
        'zip': zip.text,
      }, headers: {
        'Authorization': 'Token $token'
      });
      print(response.body);
      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Registration Successful',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        GetStorage().write('token', token.value);
        Get.off(() => HomePage());
      } else {
        Get.snackbar(
          'Error',
          'Registration Failed',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        'Error',
        'Please enter all the fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
  }
}
