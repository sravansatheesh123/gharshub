import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gharshub/core/api_constants.dart';

class MonthlyTimesheetService {
  Future<Map<String, dynamic>> getMonthlyTimesheet({
    required String token,
  }) async {
    final url = ApiConstants.monthlyTimesheet;

    final headers = <String, String>{
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    try {
      print("✅ Monthly Timesheet API URL => $url");
      print("✅ Monthly Timesheet Headers => {Content-Type: application/json, Authorization: Bearer *****}");

      final response = await http.get(Uri.parse(url), headers: headers);

      print("✅ Monthly Timesheet StatusCode => ${response.statusCode}");
      print("✅ Monthly Timesheet Body => ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("API Error ${response.statusCode}: ${response.body}");
      }
    } catch (e, s) {
      print("❌ MonthlyTimesheetService ERROR => $e");
      print("❌ MonthlyTimesheetService STACKTRACE => $s");
      rethrow;
    }
  }
}
