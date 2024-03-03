import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iotdustbin/Auth/controllers/registrationController.dart';
import 'package:iotdustbin/Auth/screens/login.dart';
import 'package:iotdustbin/Home/homepage.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RegistrationContorller registrationContorller =
        Get.put(RegistrationContorller());
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Card(
          child: SingleChildScrollView(
            child: Column(
              children: [
                InputField(
                  controller: registrationContorller.emailController,
                  labelText: 'Email',
                ),
                InputField(
                  controller: registrationContorller.passwordController,
                  labelText: 'Password',
                  obscureText: true,
                ),
                InputField(
                  controller: registrationContorller.phNo,
                  labelText: 'Phone Number',
                ),
                InputField(
                  controller: registrationContorller.address,
                  labelText: 'Address',
                ),
                InputField(
                  controller: registrationContorller.name,
                  labelText: 'Name',
                ),
                InputField(
                  controller: registrationContorller.state,
                  labelText: 'State',
                ),
                InputField(
                  controller: registrationContorller.zip,
                  labelText: 'Zip',
                ),
                ElevatedButton(
                  onPressed: () async {
                    await registrationContorller.register();
                    await registrationContorller.a();
                    // Get.offAllNamed('/home');
                    // Get.off(HomePage());
                    // Get.offAll(LoginPage());
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
