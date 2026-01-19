import 'dart:convert';
import 'package:http/http.dart' as http;
<<<<<<< HEAD
import '../../core/api_constants.dart';
import '../../models/auth/login_response_model.dart';


=======

import '../../core/api_constants.dart';
import '../../models/auth/login_response_model.dart';

>>>>>>> 4bc64c5 (updated)
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
<<<<<<< HEAD
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

=======
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    print("LOGIN API URL => $url");
    print("LOGIN API STATUS => ${response.statusCode}");
    print("LOGIN API RESPONSE => ${response.body}");

>>>>>>> 4bc64c5 (updated)
    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return LoginResponseModel.fromJson(data);
    } else {
<<<<<<< HEAD
      // API error message
=======
>>>>>>> 4bc64c5 (updated)
      final msg = data["message"] ?? "Login failed";
      throw Exception(msg);
    }
  }
}
