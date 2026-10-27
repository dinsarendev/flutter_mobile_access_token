import 'package:flutter/material.dart';
import 'package:flutter_mobile_access_token/feature/auth/login/login_controller.dart';
import 'package:flutter_mobile_access_token/widgets/button_custom_widget.dart';
import 'package:flutter_mobile_access_token/widgets/input_custom_widget.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Brand Icon & Badge
                  Center(
                    child: Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: const Color(0xFFE0E7FF),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4F46E5).withOpacity(0.10),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.lock_person_rounded,
                        size: 38,
                        color: Color(0xFF4F46E5),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Header Typography
                  const Center(
                    child: Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Center(
                    child: Text(
                      "Sign in with your phone or username to continue",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                        height: 1.4,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Card Container for Form
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFF1F5F9)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0F172A).withOpacity(0.04),
                          blurRadius: 24,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Username Field
                        InputCustomWidget(
                          labelText: "Phone or Username",
                          hintText: "Enter username or phone number",
                          controller: controller.usernameController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          prefixIcon: const Icon(
                            Icons.person_outline_rounded,
                            color: Color(0xFF64748B),
                            size: 22,
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Password Field with Eye Toggle
                        Obx(() => InputCustomWidget(
                              labelText: "Password",
                              hintText: "Enter your password",
                              controller: controller.passwordController,
                              obscureText: !controller.isPasswordVisible.value,
                              textInputAction: TextInputAction.done,
                              onSubmitted: (_) => controller.onLogin(),
                              prefixIcon: const Icon(
                                Icons.lock_outline_rounded,
                                color: Color(0xFF64748B),
                                size: 22,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isPasswordVisible.value
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: const Color(0xFF94A3B8),
                                  size: 20,
                                ),
                                onPressed: controller.togglePasswordVisibility,
                              ),
                            )),

                        const SizedBox(height: 12),

                        // Remember Me & Forgot Password Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Obx(() => SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: Checkbox(
                                        value: controller.rememberMe.value,
                                        activeColor: const Color(0xFF4F46E5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        onChanged: controller.toggleRememberMe,
                                      ),
                                    )),
                                const SizedBox(width: 8),
                                const Text(
                                  "Remember me",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF475569),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                Get.snackbar(
                                  "Forgot Password",
                                  "Please contact your administrator to reset password",
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(50, 30),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                "Forgot password?",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF4F46E5),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Submit Button
                        Obx(() => ButtonCustomWidget(
                              loading: controller.loading.value,
                              title: "Sign In",
                              icon: Icons.login_rounded,
                              onClick: () {
                                if (!controller.loading.value) {
                                  controller.onLogin();
                                }
                              },
                            )),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Footer
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: Color(0xFF64748B),
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.snackbar(
                              "Sign Up",
                              "Registration is managed by system administrator.",
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Color(0xFF4F46E5),
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
