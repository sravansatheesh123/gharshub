import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/api_constants.dart';
import '../../models/auth/forgot_password_response_model.dart';

class ForgotPasswordService {
  static Future<ForgotPasswordResponseModel> forgotPassword({
    required String identifier,
  }) async {
    final url = Uri.parse(ApiConstants.forgotPassword);

    final body = {
      "identifier": identifier,
    };

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );


    print("FORGOT API URL => $url");
    print("FORGOT API STATUS => ${response.statusCode}");
    print("FORGOT API RESPONSE => ${response.body}");

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ForgotPasswordResponseModel.fromJson(data);
    } else {
      final msg = data["message"] ?? "Forgot password failed";
      throw Exception(msg);
    }
  }
}
