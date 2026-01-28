import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/api_constants.dart';
import '../../models/leave/recent_leave_model.dart';

class RecentLeaveService {
  Future<RecentLeaveResponse> getRecentLeaves({
    required String token,
  }) async {
    final url = Uri.parse(ApiConstants.latestLeave);

    print("📌 RECENT LEAVE API URL => $url");

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print("📥 RECENT LEAVE STATUS => ${response.statusCode}");
    print("📥 RECENT LEAVE BODY => ${response.body}");

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return RecentLeaveResponse.fromJson(data);
    }

    throw Exception(data["message"] ?? "Failed to fetch recent leaves");
  }

}
