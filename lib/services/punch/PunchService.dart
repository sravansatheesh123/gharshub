import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/api_constants.dart';
import '../../models/punch/monthly_days_worked_model.dart';
import '../../models/punch/monthly_summary_model.dart';
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

    print(" PUNCH TOGGLE STATUS CODE => ${response.statusCode}");
    print(" PUNCH TOGGLE RESPONSE => $data");

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

    print(" TODAY PUNCH STATUS CODE => ${response.statusCode}");
    print(" TODAY PUNCH RESPONSE => $data");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return PunchTodayResponseModel.fromJson(data);
    }

    final message = data["message"] ?? "Failed to fetch today punch";
    throw Exception(message);
  }

  Future<MonthlyDaysWorkedResponse> getMonthlyDaysWorked({
    required String token,
  }) async {
    final url = Uri.parse(ApiConstants.monthlyDaysWorked);

    final res = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    final body = jsonDecode(res.body);

    print(" MONTHLY DAYS WORKED STATUS CODE => ${res.statusCode}");
    print(" MONTHLY DAYS WORKED RESPONSE => $body");

    if (res.statusCode == 200) {
      final model = MonthlyDaysWorkedResponse.fromJson(body);

      print(" Days Worked => ${model.data?.daysWorked}");
      print(" Month => ${model.data?.month}");
      print(" Year => ${model.data?.year}");
      print(" Till Date => ${model.data?.tillDate}");

      return model;
    } else {
      throw Exception(body["message"] ?? "Failed to fetch monthly days worked");
    }
  }

  Future<MonthlySummaryResponse> getMonthlySummary({
    required String token,
  }) async {
    final url = Uri.parse(ApiConstants.monthlySummary);

    final res = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    final body = jsonDecode(res.body);

    print("MONTHLY SUMMARY STATUS CODE => ${res.statusCode}");
    print(" MONTHLY SUMMARY RESPONSE => $body");

    if (res.statusCode == 200) {
      final model = MonthlySummaryResponse.fromJson(body);

      final normalHours = model.summary?.totalWorkHours ?? 0;
      final normalOT = model.summary?.totalNormalOvertime ?? 0;
      final holidayOT = model.summary?.totalHolidayOvertime ?? 0;

      final totalHours = normalHours + normalOT + holidayOT;

      print(" Normal Hours => $normalHours");
      print(" Normal Overtime => $normalOT");
      print(" Holiday Overtime => $holidayOT");
      print(" TOTAL HOURS CALCULATION => $normalHours + $normalOT + $holidayOT = $totalHours");

      return model;
    } else {
      throw Exception(body["message"] ?? "Failed to fetch monthly summary");
    }
  }
}
