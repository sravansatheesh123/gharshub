import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bindings/dashboard_binding.dart';
import '../../core/storage_keys.dart';
import '../../screen/Supervisor/supervisordashboard/supervisordashboard.dart';
import '../../services/auth/auth_service.dart';
import '../../screen/dashboard/dashboard_page.dart';

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

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString(StorageKeys.token, res.token);
      await prefs.setString(StorageKeys.userId, res.user.id);
      await prefs.setString(StorageKeys.username, res.user.username);
      await prefs.setString(StorageKeys.role, res.user.role);
      await prefs.setString(StorageKeys.name, res.user.name);

      await prefs.setInt(
        StorageKeys.loginTime,
        DateTime.now().millisecondsSinceEpoch,
      );

      Get.snackbar("Success", "Login successful");

      final role = (res.user.role).toLowerCase().trim();

      if (role == "supervisor" || role == "site_supervisor") {
        Get.offAll(() => const SupervisorDashboard());
      } else {

        DashboardBinding().dependencies();
        Get.offAll(() => DashboardPage());
      }

    } catch (e) {
      Get.snackbar("Login Failed", e.toString().replaceAll("Exception:", ""));
    } finally {
      isLoading.value = false;
    }
  }

  void signInAsSupervisor() {
    onSignIn();
  }

  void signInAsTechnician() {
    onSignIn();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
