import 'dart:convert';

import 'package:gharshub/core/api_constants.dart';
import 'package:gharshub/models/recent_receipt.dart';
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
}
