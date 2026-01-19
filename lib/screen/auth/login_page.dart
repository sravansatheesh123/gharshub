import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gharshub/core/app_colors.dart';
import '../../controller/auth/login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    final horizontalPadding = w < 400 ? 16.0 : 22.0;
    final maxFormWidth = w > 600 ? 430.0 : double.infinity;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whiteColor,
      body: Container(
        color: AppColors.whiteColor,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: h * 0.03,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxFormWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: h * 0.02),
                    Image.asset(
                      "assets/img/login_img.png",
                      height: 55,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Access your project workspace",
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                    SizedBox(height: h * 0.04),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Email or Mobile",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: controller.emailController,
                      decoration: InputDecoration(
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
                    ),
                    const SizedBox(height: 6),
                    Obx(
                      () => controller.emailError.value.isEmpty
                          ? const SizedBox()
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
                    const SizedBox(height: 16),

                    // Password
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Password",
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
                        controller: controller.passwordController,
                        obscureText: !controller.isPasswordVisible.value,
                        decoration: InputDecoration(
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
                            onTap: controller.togglePassword,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              child: Center(
                                widthFactor: 1,
                                child: Text(
                                  controller.isPasswordVisible.value
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
                          suffixIconConstraints: const BoxConstraints(
                            minWidth: 70,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Obx(
                      () => controller.passwordError.value.isEmpty
                          ? const SizedBox()
                          : Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                controller.passwordError.value,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                    ),

                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Obx(
                          () => Checkbox(
                            value: controller.rememberMe.value,
                            onChanged: controller.toggleRemember,
                            activeColor: const Color(0xFF0A3D91),
                          ),
                        ),
                        const Text(
                          "Remember me",
                          style: TextStyle(fontSize: 13),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: controller.onForgotPassword,
                          child: const Text(
                            "Forgot password?",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF0A3D91),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : controller.onSignIn,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0A2E6E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: controller.isLoading.value
                              ? SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: AppColors.whiteColor,
                                  ),
                                )
                              : Text(
                                  "Sign in",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "or",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                      ],
                    ),

                    const SizedBox(height: 18),

                    SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: OutlinedButton(
                        onPressed: controller.signInAsSupervisor,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF0A3D91)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Sign in as site supervisor",
                          style: TextStyle(
                            color: Color(0xFF0A3D91),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: OutlinedButton(
                        onPressed: controller.signInAsTechnician,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF0A3D91)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Sign in as technician",
                          style: TextStyle(
                            color: Color(0xFF0A3D91),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    const Text(
                      "By continuing, you agree to Terms & Privacy.",
                      style: TextStyle(fontSize: 11, color: Colors.black54),
                    ),
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
