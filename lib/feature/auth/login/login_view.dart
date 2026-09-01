import 'package:flutter/material.dart';
import 'package:flutter_mobile_access_token/feature/auth/login/login_controller.dart';
import 'package:flutter_mobile_access_token/widgets/button_custom_widget.dart';
import 'package:flutter_mobile_access_token/widgets/input_custom_widget.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.cyan, title: Text("Login")),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 35),
          child: Column(
            children: [
              InputCustomWidget(
                hintText: "Username or Phone",
                controller: controller.usernameController.value,
              ),
              InputCustomWidget(
                hintText: "Password",
                controller: controller.passwordController.value,
              ),
              ButtonCustomWidget(
                loading: controller.loading.value,
                title: "Login",
                onClick: () {
                  if (controller.loading.value == true) {
                    return;
                  }
                  controller.onLogin();
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
