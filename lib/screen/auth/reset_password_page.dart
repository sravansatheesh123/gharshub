import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gharshub/core/app_colors.dart';
import '../../controller/auth/reset_password_controller.dart';

class ResetPasswordPage extends StatelessWidget {
  final String token;
  const ResetPasswordPage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResetPasswordController(token: token));

    final w = MediaQuery.of(context).size.width;
    final maxWidth = w > 600 ? 430.0 : double.infinity;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 25,
                      spreadRadius: 2,
                      color: Colors.black.withOpacity(0.08),
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),
                    const Text(
                      "Reset Password",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Enter your new password below",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 22),

                    // New password
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "New Password",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                          () => TextField(
                        controller: controller.newPasswordController,
                        obscureText: !controller.isNewPassVisible.value,
                        decoration: InputDecoration(
                          hintText: "Minimum 8 characters",
                          filled: true,
                          fillColor: AppColors.whiteColor,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xFF0A3D91),
                              width: 1.3,
                            ),
                          ),
                          suffixIcon: InkWell(
                            onTap: controller.toggleNewPass,
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 14),
                              child: Center(
                                widthFactor: 1,
                                child: Text(
                                  controller.isNewPassVisible.value
                                      ? "Hide"
                                      : "Show",
                                  style: const TextStyle(
                                    color: Color(0xFF0A3D91),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          suffixIconConstraints:
                          const BoxConstraints(minWidth: 70),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Obx(
                          () => controller.newPassError.value.isEmpty
                          ? const SizedBox()
                          : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          controller.newPassError.value,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Confirm password
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Confirm Password",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                          () => TextField(
                        controller: controller.confirmPasswordController,
                        obscureText: !controller.isConfirmPassVisible.value,
                        decoration: InputDecoration(
                          hintText: "Re-enter your password",
                          filled: true,
                          fillColor: AppColors.whiteColor,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xFF0A3D91),
                              width: 1.3,
                            ),
                          ),
                          suffixIcon: InkWell(
                            onTap: controller.toggleConfirmPass,
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 14),
                              child: Center(
                                widthFactor: 1,
                                child: Text(
                                  controller.isConfirmPassVisible.value
                                      ? "Hide"
                                      : "Show",
                                  style: const TextStyle(
                                    color: Color(0xFF0A3D91),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          suffixIconConstraints:
                          const BoxConstraints(minWidth: 70),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Obx(
                          () => controller.confirmPassError.value.isEmpty
                          ? const SizedBox()
                          : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          controller.confirmPassError.value,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Reset button
                    Obx(
                          () => SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : controller.onResetPassword,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0A2E6E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: controller.isLoading.value
                              ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                              : const Text(
                            "Reset Password",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    InkWell(
                      onTap: controller.goBackToLogin,
                      child: const Text(
                        "Back to Login",
                        style: TextStyle(
                          color: Color(0xFF0A3D91),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
