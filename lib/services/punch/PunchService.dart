import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/api_constants.dart';
import '../../models/punch/punch_toggle_model.dart';
import '../../models/punch/punch_today_model.dart';

class PunchService {
  Future<PunchToggleResponseModel> togglePunch({
    required String token,
    required String action,
  }) async {
    final url = Uri.parse(ApiConstants.punchToggle);

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"action": action}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return PunchToggleResponseModel.fromJson(data);
    }

    final message = data["message"] ?? "Punch failed";
    throw Exception(message);
  }

  Future<PunchTodayResponseModel> getTodayPunch({
    required String token,
  }) async {
    final url = Uri.parse(ApiConstants.punchToday);

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return PunchTodayResponseModel.fromJson(data);
    }

    final message = data["message"] ?? "Failed to fetch today punch";
    throw Exception(message);
  }
}
