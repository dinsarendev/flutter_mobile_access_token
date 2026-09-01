import 'package:flutter_mobile_access_token/feature/auth/login/login_controller.dart';
import 'package:flutter_mobile_access_token/feature/auth/repository/auth_repository.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(authRepository: Get.find<AuthRepository>()),
    );
  }
}
