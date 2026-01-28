import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/api_constants.dart';

class SalaryReceiptService {
  Future<String> generateWebSigningToken({
    required int month,
    required int year,
    required String token,
  }) async {
    final url = Uri.parse(ApiConstants.generateWebSigningToken(month, year));

    final res = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print("✅ generateWebSigningToken URL => $url");
    print("✅ generateWebSigningToken STATUS => ${res.statusCode}");
    print("✅ generateWebSigningToken BODY => ${res.body}");

    final data = jsonDecode(res.body);

    if (res.statusCode == 200 || res.statusCode == 201) {
      final webUrl = data["data"]?["webUrl"];
      if (webUrl == null || webUrl.toString().isEmpty) {
        throw Exception("webUrl not found in response");
      }
      return webUrl.toString();
    } else {
      throw Exception(data["error"]?.toString() ?? "Token generation failed");
    }
  }
}
