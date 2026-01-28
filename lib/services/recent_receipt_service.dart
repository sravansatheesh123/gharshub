import 'dart:convert';

import 'package:gharshub/core/api_constants.dart';
import 'package:gharshub/models/my_recent_receipt.dart';
import 'package:gharshub/models/submit_request_model.dart';
import 'package:http/http.dart' as http;

class RecentReceiptService {
  Future<RecentReceiptModel> getrecentReceipt({required String token}) async {
    final url = Uri.parse(ApiConstants.getRecentReceipt);

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    final data = jsonDecode(response.body);

    print(" Get receipt => ${response.statusCode}");
    print(" receipt data => $data");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return RecentReceiptModel.fromJson(data);
    }

    throw Exception("");
  }

  Future<SubmitRequestModel> submitRequestReceipt({
    required String token,
    month,
    year,
    reason,
  }) async {
    final url = Uri.parse(ApiConstants.submitRecentReceipt);

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"month": month, "year": year, "reason": token}),
    );

    final data = jsonDecode(response.body);

    print("Get receipt => ${response.statusCode}");
    print("Receipt data => $data");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return SubmitRequestModel.fromJson(data);
    }
    if (response.statusCode == 404) {
      return SubmitRequestModel.fromJson(data);
    } else {
      throw Exception("Failed to submit receipt request");
    }
  }
}
