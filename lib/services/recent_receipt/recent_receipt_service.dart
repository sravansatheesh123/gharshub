import 'dart:convert';
import 'dart:io';
import 'package:gharshub/core/api_constants.dart';
import 'package:gharshub/models/my_recent_receipt.dart';
import 'package:gharshub/models/submit_request_model.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';


class RecentReceiptService {
  Future<RecentReceiptModel> getrecentReceipt({required String token}) async {
    final url = Uri.parse(ApiConstants.getRecentReceipt);

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    final data = jsonDecode(response.body);

    print(" Get receipt => ${response.statusCode}");
    print(" receipt data => $data");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return RecentReceiptModel.fromJson(data);
    }

    throw Exception("");
  }

  Future<SubmitRequestModel> submitRequestReceipt({
    required String token,
    month,
    year,
    reason,
  }) async {
    final url = Uri.parse(ApiConstants.submitRecentReceipt);

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"month": month, "year": year, "reason": token}),
    );

    final data = jsonDecode(response.body);

    print("Get receipt => ${response.statusCode}");
    print("Receipt data => $data");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return SubmitRequestModel.fromJson(data);
    }
    if (response.statusCode == 404) {
      return SubmitRequestModel.fromJson(data);
    } else {
      throw Exception("Failed to submit receipt request");
    }
  }

  Future<void> downloadRecentReceiptPdf({
    required String token,
    required String employeeId,
    required int month,
    required int year,
  }) async {
    try {
      print("📥 Starting receipt download...");
      print("➡ EmployeeId: $employeeId");
      print("➡ Month: $month | Year: $year");

      final permission = await Permission.storage.request();
      print("🔐 Storage permission status: ${permission.isGranted}");

      if (!permission.isGranted) {
        throw Exception("Storage permission denied");
      }

      final apiUrl =
      ApiConstants.downloadRecentReceipt(employeeId, month, year);

      print("🌐 Calling download URL API: $apiUrl");

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      print("📡 API Status: ${response.statusCode}");
      print("📦 API Response: ${response.body}");

      if (response.statusCode != 200) {
        throw Exception("Download URL API failed");
      }

      final data = jsonDecode(response.body);
      final downloadUrl = data["data"]["downloadUrl"];
      final fileName = data["data"]["fileName"];

      print("🔗 S3 URL: $downloadUrl");
      print("📄 File: $fileName");

      final pdfRes = await http.get(Uri.parse(downloadUrl));
      print("📥 PDF Status: ${pdfRes.statusCode}");
      print("📦 PDF Bytes: ${pdfRes.bodyBytes.length}");

      final dir = Directory("/storage/emulated/0/Download");
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }

      final filePath = "${dir.path}/$fileName";
      await File(filePath).writeAsBytes(pdfRes.bodyBytes);

      print("✅ Saved at: $filePath");

      await OpenFilex.open(filePath);
      print("🎉 PDF opened successfully");
    } catch (e, s) {
      print("❌ SERVICE ERROR: $e");
      print("📌 STACKTRACE:");
      print(s);
      rethrow; // 🔥 send error back to controller
    }
  }


}