import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/api_constants.dart';
import '../../models/leave/recent_leave_model.dart';

class RecentLeaveService {
  Future<RecentLeaveResponse> getRecentLeaves({
    required String token,
  }) async {
    final url = Uri.parse(ApiConstants.recentLeaves);

    print("📌 RECENT LEAVE API URL => $url");
    print("🔑 TOKEN => ${token.substring(0, 10)}...");

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print("📥 STATUS CODE => ${response.statusCode}");
    print("📥 RAW RESPONSE => ${response.body}");

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print("✅ PARSED JSON => $data");
      return RecentLeaveResponse.fromJson(data);
    }

    throw Exception(data["message"] ?? "Failed to fetch recent leaves");
  }
}

