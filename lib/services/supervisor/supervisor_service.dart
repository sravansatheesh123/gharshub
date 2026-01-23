import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/api_constants.dart';
import '../../core/storage_keys.dart';
import '../../models/supervisor/supervisor_dashboard_model.dart';

class SupervisorService {
  static Future<SupervisorDashboardModel> getDashboardSummary() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(StorageKeys.token) ?? "";

    final url = Uri.parse(ApiConstants.supervisorDashboardSummary);

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print("SUPERVISOR DASHBOARD URL => $url");
    print("SUPERVISOR DASHBOARD STATUS => ${response.statusCode}");
    print("SUPERVISOR DASHBOARD RESPONSE => ${response.body}");

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return SupervisorDashboardModel.fromJson(data);
    } else {
      final msg = data["message"] ?? "Failed to load supervisor dashboard";
      throw Exception(msg);
    }
  }
}
