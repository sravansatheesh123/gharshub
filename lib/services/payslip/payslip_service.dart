import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/api_constants.dart';

class PayslipService {
  Future<Map<String, dynamic>> getSalaryDetails({
    required String employeeId,
    required String year,
    String? token,
  }) async {
    final url = ApiConstants.salaryDetails(employeeId, year);

    final headers = <String, String>{
      "Content-Type": "application/json",
    };

    if (token != null && token.isNotEmpty) {
      headers["Authorization"] = "Bearer $token";
    }

    try {
      print("✅ Payslip API URL => $url");
      print("✅ Payslip API Headers => ${{
        ...headers,
        "Authorization": headers["Authorization"] != null ? "Bearer *****" : "NO_TOKEN"
      }}");

      final response = await http.get(Uri.parse(url), headers: headers);

      print("✅ Payslip API StatusCode => ${response.statusCode}");
      print("✅ Payslip API Response Body => ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("API Error ${response.statusCode}: ${response.body}");
      }
    } catch (e, s) {
      print("❌ PayslipService ERROR => $e");
      print("❌ PayslipService STACKTRACE => $s");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> uploadSignature({
    required String token,
    required String employeeId,
    required int month,
    required int year,
    required String fileData, // data:image/png;base64,...
  }) async {
    final url = Uri.parse(
      ApiConstants.submitSignature(employeeId, month, year),
    );

    print("📌 uploadSignature API URL => $url");

    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "signatureType": "upload",
        "fileName": "signature.png",
        "fileData": fileData,
      }),
    );

    print("📥 uploadSignature Status => ${response.statusCode}");
    print("📥 uploadSignature Response => ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Signature upload failed: ${response.body}");
    }
  }

}