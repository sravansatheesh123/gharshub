import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/auth/reset_password_service.dart';
import '../../screen/auth/login_page.dart';

class ResetPasswordController extends GetxController {
  final String token;

  ResetPasswordController({required this.token});

  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isNewPassVisible = false.obs;
  var isConfirmPassVisible = false.obs;
  var isLoading = false.obs;

  var newPassError = "".obs;
  var confirmPassError = "".obs;

  void toggleNewPass() {
    isNewPassVisible.value = !isNewPassVisible.value;
  }

  void toggleConfirmPass() {
    isConfirmPassVisible.value = !isConfirmPassVisible.value;
  }

  bool validate() {
    newPassError.value = "";
    confirmPassError.value = "";

    final newPass = newPasswordController.text.trim();
    final confirmPass = confirmPasswordController.text.trim();

    if (newPass.isEmpty) {
      newPassError.value = "Password is required";
      return false;
    }

    if (newPass.length < 8) {
      newPassError.value = "Minimum 8 characters required";
      return false;
    }

    if (confirmPass.isEmpty) {
      confirmPassError.value = "Confirm password is required";
      return false;
    }

    if (newPass != confirmPass) {
      confirmPassError.value = "Password does not match";
      return false;
    }

    return true;
  }

  Future<void> onResetPassword() async {
    if (!validate()) return;

    try {
      isLoading.value = true;

      final res = await ResetPasswordService.resetPassword(
        token: token,
        password: newPasswordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
      );

      Get.snackbar("Success", res.message);

      // ✅ Navigate to login
      Get.offAll(() => LoginPage());
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString().replaceAll("Exception:", "").trim(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void goBackToLogin() {
    Get.offAll(() => LoginPage());
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
