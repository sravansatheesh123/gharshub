import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signature/signature.dart';
import 'dart:convert';
import '../../../core/storage_keys.dart';
import '../../../models/payslip/payslip.dart';
import '../../../services/payslip/payslip_service.dart';

class PayslipController extends GetxController {
  late SignatureController signatureController;

  Rx<Uint8List?> signatureImage = Rx<Uint8List?>(null);

  // API states
  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;
  Rxn<PayslipData> payslipData = Rxn<PayslipData>();

  final PayslipService _service = PayslipService();

  @override
  void onInit() {
    super.onInit();

    signatureController = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
    );
  }

  // ✅ Get Token
  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(StorageKeys.token) ?? "";

    print("✅ Stored Token Length => ${token.length}");
    print(
      "✅ Stored Token Preview => ${token.isNotEmpty ? token.substring(0, token.length > 15 ? 15 : token.length) : "EMPTY"}",
    );

    return token;
  }

  // ✅ Fetch Salary Details API
  Future<void> fetchSalaryDetails({
    required String employeeId,
    required String year,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = "";
      payslipData.value = null;

      print("📌 fetchSalaryDetails called");
      print("📌 employeeId => $employeeId");
      print("📌 year => $year");

      final token = await _getToken();

      if (token.isEmpty) {
        errorMessage.value = "Token missing. Please login again.";
        return;
      }

      final response = await _service.getSalaryDetails(
        employeeId: employeeId,
        year: year,
        token: token,
      );

      print("✅ Salary Details API Parsed Response => $response");

      if (response["success"] == true) {
        final data = response["data"];

        // ✅ empty data
        if (data == null || data is! Map || data.isEmpty) {
          errorMessage.value = "No payslip available for this year ($year).";
          return;
        }

        // ✅ API sometimes returns { "0": {...} }
        dynamic record;
        if (data.containsKey("0")) {
          record = data["0"];
        } else {
          record = data;
        }

        print("✅ Salary Record => $record");

        if (record == null || record is! Map<String, dynamic>) {
          errorMessage.value = "Payslip format invalid. Please contact admin.";
          return;
        }

        payslipData.value = PayslipData.fromJson(record);
      } else {
        errorMessage.value =
            response["error"]?.toString() ?? "No payslip found";
      }
    } catch (e, s) {
      print("❌ PayslipController ERROR => $e");
      print("❌ PayslipController STACKTRACE => $s");

      final msg = e.toString();

      // ✅ Proper 403 message
      if (msg.contains("403") || msg.toLowerCase().contains("not authorized")) {
        errorMessage.value =
            "You are not authorized to view this payslip.\nOnly HR/Admin can access.";
      } else {
        errorMessage.value = msg.replaceAll("Exception:", "").trim();
      }
    } finally {
      isLoading.value = false;
      print("📌 fetchSalaryDetails finished (loading false)");
    }
  }

  void clearSignature() {
    signatureController.clear();
    signatureImage.value = null;
  }

  Future<void> saveSignature({
    required String employeeId,
    required int month,
    required int year,
  }) async {
    print("🖊️ saveSignature() called");
    if (payslipData.value?.signatureStatus == "signed") {
      Get.snackbar(
        "Already Signed",
        "This payslip is already signed",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (signatureController.isEmpty) {
      print("⚠️ Signature controller is empty");
      Get.snackbar("Error", "Please sign before saving");
      return;
    }

    try {
      isLoading.value = true;

      // 🔹 Capture signature
      final imageBytes = await signatureController.toPngBytes();
      if (imageBytes == null) {
        throw Exception("Failed to capture signature");
      }

      signatureImage.value = imageBytes;

      // 🔹 BASE64 CONVERSION (SAME AS OLD CODE)
      final String base64Data = base64Encode(imageBytes);
      final String fileData = "data:image/png;base64,$base64Data";

      print("📦 Base64 Length => ${fileData.length}");

      // ❌ OLD METHOD (COMMENTED – DO NOT USE)
      /*
    post_signature_to_backend(fileData);
    */

      final token = await _getToken();
      if (token.isEmpty) {
        Get.snackbar("Auth Error", "Token missing. Login again.");
        return;
      }

      final response = await _service.uploadSignature(
        token: token,
        employeeId: employeeId,
        month: month,
        year: year,
        fileData: fileData,
      );

      Get.snackbar(
        "Signature",
        response["message"] ?? "Signature uploaded successfully",
      );

    } catch (e) {
      print("❌ saveSignature ERROR => $e");
      Get.snackbar(
        "Error",
        e.toString().replaceAll("Exception:", ""),
      );
    } finally {
      isLoading.value = false;
    }
  }


  @override
  void onClose() {
    signatureController.dispose();
    super.onClose();
  }

  /*
 LEGACY CODE – DO NOT USE
This was written by previous developer.
Kept only for reference.

post_signature_to_backend(
  String fileData,
) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString(StorageKeys.token) ?? "";
  final url = Uri.parse(
    'https://api.gharshub.com/api/salary-receipts/signature/6977434079760c6e6b90eadc/0/2027',
  );

  final headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  };

  final body = jsonEncode({
    "signatureType": "upload",
    "fileName": "signature.png",
    "fileData": fileData,
  });

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode != 200) {
    throw Exception("Signature upload failed");
  }
}
*/
  Future<void> saveSignatureUsingService({
    required String employeeId,
    required int month,
    required int year,
  }) async {
    try {
      print("🖊️ saveSignatureUsingService() called");

      if (signatureController.isEmpty) {
        Get.snackbar("Error", "Please sign before submitting");
        return;
      }

      isLoading.value = true;

      final token = await _getToken();
      if (token.isEmpty) {
        Get.snackbar("Auth Error", "Token missing. Login again.");
        return;
      }

      final imageBytes = await signatureController.toPngBytes();
      if (imageBytes == null) {
        throw Exception("Failed to capture signature image");
      }

      final base64Data = base64Encode(imageBytes);
      final fileData = "data:image/png;base64,$base64Data";

      final response = await _service.uploadSignature(
        token: token,
        employeeId: employeeId,
        month: month,
        year: year,
        fileData: fileData,
      );

      print("✅ Signature Uploaded => $response");

      Get.snackbar(
        "Signature",
        response["message"] ?? "Signature uploaded successfully",
      );

    } catch (e, s) {
      print("❌ saveSignatureUsingService ERROR => $e");
      print("❌ STACKTRACE => $s");

      Get.snackbar("Error", e.toString().replaceAll("Exception:", ""));
    } finally {
      isLoading.value = false;
    }
  }

}
