import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/auth/login_controller.dart';


class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            width: 430,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Sign in",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Access your project workspace",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 22),

                // Email / Mobile
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
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 14),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      const BorderSide(color: Color(0xFF0A3D91), width: 1.3),
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
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 14),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color(0xFF0A3D91), width: 1.3),
                      ),
                      suffixIcon: InkWell(
                        onTap: controller.togglePassword,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
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
                      suffixIconConstraints:
                      const BoxConstraints(minWidth: 70),
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

                // Remember + Forgot
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

                // Sign in Button
                Obx(
                      () => SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed:
                      controller.isLoading.value ? null : controller.onSignIn,
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
                        "Sign in",
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

                // Divider OR
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

                // Role Buttons
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

                const SizedBox(height: 18),
                const Text(
                  "By continuing, you agree to Terms & Privacy.",
                  style: TextStyle(fontSize: 11, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
