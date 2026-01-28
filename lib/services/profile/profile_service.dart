import 'dart:convert';

import 'package:gharshub/core/api_constants.dart';
import 'package:gharshub/models/profile/profile_model.dart';
import 'package:http/http.dart' as http;

class ProfileService {


  Future<ProfileModel> profile(
      token,
      ) async {
    final url = Uri.parse(ApiConstants.profile);

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    final data = jsonDecode(response.body);

    print("Get receipt => ${response.statusCode}");
    print("Receipt data => $data");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ProfileModel.fromJson(data);
    }
    if (response.statusCode == 404) {
      return ProfileModel.fromJson(data);
    } else {
      throw Exception("Failed to submit receipt request");
    }
  }


}