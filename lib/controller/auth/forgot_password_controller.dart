import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/auth/forgot_password_service.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();

  var isLoading = false.obs;
  var emailError = "".obs;

  void clearAll() {
    emailController.clear();
    emailError.value = "";
  }

  bool validateEmail() {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      emailError.value = "Email is required";
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      emailError.value = "Enter valid email address";
      return false;
    }

    emailError.value = "";
    return true;
  }

  Future<void> sendResetLink() async {
    if (!validateEmail()) return;

    try {
      isLoading.value = true;

      final res = await ForgotPasswordService.forgotPassword(
        identifier: emailController.text.trim(),
      );

      Get.back(); // close popup
      Get.snackbar("Success", res.message);
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString().replaceAll("Exception:", "").trim(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
