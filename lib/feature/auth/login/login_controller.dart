import 'package:flutter/cupertino.dart';
import 'package:flutter_mobile_access_token/feature/auth/repository/auth_repository.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var usernameController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  final AuthRepository authRepository;
  final loading = true.obs;
  LoginController({required this.authRepository});


  onLogin() async {
    var username = usernameController.value.text.trim();
    var password = passwordController.value.text.trim();
    if (username.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Username and password are required");
      return;
    }
    //
    loading.value = true;
    var message = await authRepository.login(username, password);
    loading.value = false;
    Get.snackbar("Message", message);
  }
}
