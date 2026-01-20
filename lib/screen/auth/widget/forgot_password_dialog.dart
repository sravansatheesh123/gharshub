import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gharshub/core/app_colors.dart';
import '../../../controller/auth/forgot_password_controller.dart';

class ForgotPasswordDialog extends StatelessWidget {
  ForgotPasswordDialog({super.key});

  final ForgotPasswordController controller =
  Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // close icon
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  Get.back();
                  Get.delete<ForgotPasswordController>();
                },
                child: const Icon(Icons.close, size: 22),
              ),
            ),

            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: const Color(0xFFEFF3F8),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.lock_outline,
                size: 28,
                color: Color(0xFF0A3D91),
              ),
            ),

            const SizedBox(height: 14),

            const Text(
              "Forgot Password?",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              "Enter your email and we'll send you a password reset link",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.5, color: Colors.black54),
            ),

            const SizedBox(height: 18),

            Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Email Address",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const TextSpan(
                      text: " *",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "john.doe@gmail.com",
                hintStyle: const TextStyle(color: Colors.black38),
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
              ),
              onChanged: (v) => controller.emailError.value = "",
            ),

            const SizedBox(height: 6),

            Obx(
                  () => controller.emailError.value.isEmpty
                  ? Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "We'll send a reset link to this email address",
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Colors.grey.shade600,
                  ),
                ),
              )
                  : Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  controller.emailError.value,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.red,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: OutlinedButton(
                      onPressed: () {
                        Get.back();
                        Get.delete<ForgotPasswordController>();
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: Obx(
                          () => ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.sendResetLink,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0A2E6E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: controller.isLoading.value
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.3,
                            color: Colors.white,
                          ),
                        )
                            : const Text(
                          "Send Reset Link",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
