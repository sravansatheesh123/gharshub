import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/api_constants.dart';
import '../../models/auth/reset_password_response_model.dart';

class ResetPasswordService {
  static Future<ResetPasswordResponseModel> resetPassword({
    required String token,
    required String password,
    required String confirmPassword,
  }) async {
    final url = Uri.parse("${ApiConstants.baseUrl}/api/auth/reset-password");

    final body = {
      "token": token,
      "password": password,
      "confirmPassword": confirmPassword,
    };

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    print("RESET API URL => $url");
    print("RESET API STATUS => ${response.statusCode}");
    print("RESET API RESPONSE => ${response.body}");

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ResetPasswordResponseModel.fromJson(data);
    } else {
      final msg = data["message"] ?? "Reset password failed";
      throw Exception(msg);
    }
  }
}
