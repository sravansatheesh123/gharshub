import 'dart:convert';
import 'package:gharshub/models/leave/current_leave_model.dart';
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

    throw Exception(data["message"] ?? "Failed to fetch leave");
  }


  Future<CurrentLeaveModel> currentLeaveStatus({
    required String token,
  }) async {
    final url = Uri.parse(ApiConstants.currentLeave);

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return CurrentLeaveModel.fromJson(data);
    }

    throw Exception(data["message"] ?? "Failed to fetch leave");
  }
}