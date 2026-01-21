import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/api_constants.dart';
import '../../models/leave/latest_leave_model.dart';

class LeaveService {
  Future<LatestLeaveResponseModel> getLatestLeave({
    required String token,
  }) async {
    final url = Uri.parse(ApiConstants.latestLeave);

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return LatestLeaveResponseModel.fromJson(data);
    }

    final message = data["message"] ?? "Failed to fetch notification";
    throw Exception(message);
  }
}
