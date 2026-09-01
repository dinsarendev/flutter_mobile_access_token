import 'package:flutter/material.dart';
import 'package:flutter_mobile_access_token/feature/splash/splash_controller.dart';
import 'package:flutter_mobile_access_token/widgets/loading_widget.dart';
import 'package:get/get.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.cyan,
        body: controller.loading.value == true
            ? LoadingWidget(color: Colors.white)
            : Text(""),
      );
    });
  }
}
