import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/api_constants.dart';
import '../../core/storage_keys.dart';
import '../../models/supervisor/attendance_log_model.dart';
import '../../models/supervisor/technician_model.dart';

class AttendanceService {
  static Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(StorageKeys.token);

    if (token == null || token.isEmpty) {
      throw Exception("Token not found. Please login again.");
    }
    return token;
  }

  static void _printJson(String title, dynamic jsonObj) {
    try {
      const encoder = JsonEncoder.withIndent("  ");
      final pretty = encoder.convert(jsonObj);
      print("🟦 $title =>\n$pretty");
    } catch (e) {
      print("🟥 JSON PRINT ERROR => $e");
      print("🟦 RAW => $jsonObj");
    }
  }

  /// ✅ GET TECHNICIANS LIST
  static Future<List<TechnicianModel>> getTechnicians() async {
    final token = await _getToken();
    final url = Uri.parse(ApiConstants.supervisorAttendanceTechnicians);

    print("📌 TECHNICIANS URL => $url");
    print("🔑 TOKEN USED => $token");

    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    print("📌 TECHNICIANS STATUS => ${response.statusCode}");

    dynamic decoded;
    try {
      decoded = jsonDecode(response.body);
      _printJson("📌 TECHNICIANS RESPONSE(JSON)", decoded);
    } catch (_) {
      print("📌 TECHNICIANS RESPONSE(RAW) => ${response.body}");
    }

    if (response.statusCode == 200) {
      if (decoded is Map<String, dynamic> && decoded["data"] is List) {
        final list = decoded["data"] as List;
        print("✅ TECHNICIANS PARSED COUNT => ${list.length}");
        return list.map((e) => TechnicianModel.fromJson(e)).toList();
      }

      return [];
    }

    if (response.statusCode == 401) {
      throw Exception("Unauthorized. Token expired or revoked. Please login.");
    }

    throw Exception("Failed to fetch technicians");
  }

  /// ✅ GET ATTENDANCE LOGS BY DATE
  static Future<List<AttendanceLogModel>> getAttendanceLogs({
    required String date,
  }) async {
    final token = await _getToken();
    final url = Uri.parse(ApiConstants.supervisorAttendanceLogs(date));

    print("📌 ATTENDANCE LOGS URL => $url");
    print("🔑 TOKEN USED => $token");

    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    print("📌 ATTENDANCE LOGS STATUS => ${response.statusCode}");

    dynamic decoded;
    try {
      decoded = jsonDecode(response.body);
      _printJson("📌 ATTENDANCE LOGS RESPONSE(JSON)", decoded);
    } catch (_) {
      print("📌 ATTENDANCE LOGS RESPONSE(RAW) => ${response.body}");
    }

    if (response.statusCode == 200) {
      if (decoded is List) {
        print("✅ ATTENDANCE LOGS PARSED COUNT => ${decoded.length}");
        return decoded.map((e) => AttendanceLogModel.fromJson(e)).toList();
      }

      if (decoded is Map<String, dynamic> && decoded["data"] is List) {
        final list = decoded["data"] as List;
        print("✅ ATTENDANCE LOGS PARSED COUNT => ${list.length}");
        return list.map((e) => AttendanceLogModel.fromJson(e)).toList();
      }

      return [];
    }

    if (response.statusCode == 401) {
      throw Exception("Unauthorized. Token expired or revoked. Please login.");
    }

    throw Exception("Failed to fetch attendance logs");
  }

  /// ✅ BULK PUNCH IN / OUT
  static Future<Map<String, dynamic>> bulkManualPunch({
    required List<String> employeeIds,
    required String action, // "in" or "out"
    required String manualTime, // "HH:MM"
    required String date, // "YYYY-MM-DD"
  }) async {
    final token = await _getToken();
    final url = Uri.parse(ApiConstants.bulkManualPunch);

    final body = {
      "employeeIds": employeeIds,
      "action": action,
      "manualTime": manualTime,
      "date": date,
    };

    print("📌 BULK PUNCH URL => $url");
    _printJson("📌 BULK PUNCH BODY", body);

    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    print("📌 BULK PUNCH STATUS => ${response.statusCode}");

    dynamic decoded;
    try {
      decoded = jsonDecode(response.body);
      _printJson("📌 BULK PUNCH RESPONSE(JSON)", decoded);
    } catch (_) {
      print("📌 BULK PUNCH RESPONSE(RAW) => ${response.body}");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return decoded is Map<String, dynamic>
          ? decoded
          : {"message": "Success", "raw": response.body};
    }

    throw Exception(response.body);
  }

  /// ✅ EDIT PUNCH (Punch edit request)
  static Future<Map<String, dynamic>> editPunch({
    required String userId,
    required String date,
    required String editedInTime,
    required String reason,
  }) async {
    final token = await _getToken();
    final url = Uri.parse(ApiConstants.editPunch);

    final body = {
      "userId": userId,
      "date": date,
      "editedInTime": editedInTime,
      "reason": reason,
    };

    print("📌 EDIT PUNCH URL => $url");
    _printJson("📌 EDIT PUNCH BODY", body);

    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    print("📌 EDIT PUNCH STATUS => ${response.statusCode}");

    dynamic decoded;
    try {
      decoded = jsonDecode(response.body);
      _printJson("📌 EDIT PUNCH RESPONSE(JSON)", decoded);
    } catch (_) {
      print("📌 EDIT PUNCH RESPONSE(RAW) => ${response.body}");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return decoded is Map<String, dynamic>
          ? decoded
          : {"message": "Success", "raw": response.body};
    }

    throw Exception(response.body);
  }
}
