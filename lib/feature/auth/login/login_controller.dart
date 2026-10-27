import 'package:flutter/material.dart';
import 'package:flutter_mobile_access_token/feature/auth/repository/auth_repository.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthRepository authRepository;
  final loading = false.obs;
  final isPasswordVisible = false.obs;
  final rememberMe = true.obs;

  LoginController({required this.authRepository});

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleRememberMe(bool? value) {
    if (value != null) {
      rememberMe.value = value;
    }
  }

  Future<void> onLogin() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Validation",
        "Username and password are required",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        icon: const Icon(Icons.error_outline_rounded, color: Colors.white),
      );
      return;
    }

    loading.value = true;
    try {
      final message = await authRepository.login(username, password);
      loading.value = false;

      if (message != "Login Success") {
        Get.snackbar(
          "Sign In Failed",
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
        );
      }
    } catch (e) {
      loading.value = false;
      Get.snackbar(
        "Error",
        "An unexpected error occurred. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
