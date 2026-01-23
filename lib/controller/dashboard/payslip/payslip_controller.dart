import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signature/signature.dart';

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

  Future<void> saveSignature() async {
    if (signatureController.isNotEmpty) {
      final image = await signatureController.toPngBytes();
      signatureImage.value = image;
    }
  }

  @override
  void onClose() {
    signatureController.dispose();
    super.onClose();
  }
}
