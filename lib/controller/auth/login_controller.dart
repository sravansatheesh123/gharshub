import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/storage_keys.dart';
<<<<<<< HEAD
=======
import '../../screen/dashboard/dashboard_page.dart';
>>>>>>> 4bc64c5 (updated)
import '../../services/auth/auth_service.dart';



class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxBool isPasswordVisible = false.obs;
  RxBool rememberMe = false.obs;
  RxBool isLoading = false.obs;

  RxString emailError = "".obs;
  RxString passwordError = "".obs;

  void togglePassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleRemember(bool? value) {
    rememberMe.value = value ?? false;
  }

  bool _validate() {
    emailError.value = "";
    passwordError.value = "";

    if (emailController.text.trim().isEmpty) {
      emailError.value = "Enter a valid email or mobile number.";
      return false;
    }

    if (passwordController.text.trim().isEmpty) {
      passwordError.value = "Password is required.";
      return false;
    }

    return true;
  }

  Future<void> onSignIn() async {
    if (!_validate()) return;

    try {
      isLoading.value = true;

      final res = await AuthService.login(
        identifier: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

<<<<<<< HEAD
      // Save token + user data
=======
      print("TOKEN => ${res.token}");
      print("USER => ${res.user.username} | ROLE => ${res.user.role}");

>>>>>>> 4bc64c5 (updated)
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(StorageKeys.token, res.token);
      await prefs.setString(StorageKeys.userId, res.user.id);
      await prefs.setString(StorageKeys.username, res.user.username);
      await prefs.setString(StorageKeys.role, res.user.role);
      await prefs.setString(StorageKeys.name, res.user.name);

      Get.snackbar("Success", "Login successful");

<<<<<<< HEAD
      // TODO: Navigate to dashboard/home page
      // Get.offAll(() => HomePage());
=======

      Get.offAll(() => const DashboardPage());
>>>>>>> 4bc64c5 (updated)

    } catch (e) {
      Get.snackbar("Login Failed", e.toString().replaceAll("Exception:", ""));
    } finally {
      isLoading.value = false;
    }
  }

  void onForgotPassword() {
    Get.snackbar("Forgot Password", "Forgot password clicked");
  }

  void signInAsSupervisor() {
    Get.snackbar("Role", "Sign in as Site Supervisor clicked");
  }

  void signInAsTechnician() {
    Get.snackbar("Role", "Sign in as Technician clicked");
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
