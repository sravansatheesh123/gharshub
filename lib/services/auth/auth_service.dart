import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/api_constants.dart';
import '../../models/auth/login_response_model.dart';


class AuthService {
  static Future<LoginResponseModel> login({
    required String identifier,
    required String password,
  }) async {
    final url = Uri.parse(ApiConstants.login);

    final body = {
      "identifier": identifier,
      "password": password,
    };

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return LoginResponseModel.fromJson(data);
    } else {
      // API error message
      final msg = data["message"] ?? "Login failed";
      throw Exception(msg);
    }
  }
}
