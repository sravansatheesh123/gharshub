import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/api_constants.dart';
import '../../core/storage_keys.dart';
import '../../models/supervisor/supervisor_dashboard_model.dart';

class SupervisorDashBoardService {
  Future<SupervisorDashboardModel> dashboard(token) async {
    final url = Uri.parse(ApiConstants.spv_dashborad);

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
      return SupervisorDashboardModel.fromJson(data);
    }
    if (response.statusCode == 404) {
      return SupervisorDashboardModel.fromJson(data);
    } else {
      throw Exception("Failed to submit receipt request");
    }
  }
}
