import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iotdustbin/Auth/controllers/loginController.dart';
import 'package:iotdustbin/Auth/screens/register.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              // color: Colors.amber,
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.person),
                  ),
                  InputField(
                    controller: loginController.emailController,
                    labelText: 'Email',
                    hintText: 'Enter your email',
                  ),
                  InputField(
                    controller: loginController.passwordController,
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    obscureText: true,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      loginController.login();
                    },
                    child: const Text('Login'),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => RegisterScreen());
                      },
                      child: const Text('Don\'t have an account? Sign up!'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class InputField extends StatelessWidget {
  InputField(
      {super.key,
      this.controller,
      this.labelText,
      this.hintText,
      this.obscureText = false});
  TextEditingController? controller;
  String? labelText;
  String? hintText;
  bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            obscureText: obscureText,
            decoration:
                InputDecoration(labelText: labelText, border: InputBorder.none),
            controller: controller!,
          ),
        ),
      ),
    );
  }
}
