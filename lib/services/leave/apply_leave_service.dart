import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../core/api_constants.dart';
import '../../models/leave/apply_leave_model.dart';

class ApplyLeaveService {
  Future<ApplyLeaveResponseModel> applyLeave({
    required String token,
    required String reason,
    required String startDate,
    required String endDate,
    required int numberOfDays,
    File? proofFile,
  }) async {
    final uri = Uri.parse(ApiConstants.applyLeave);

    print("APPLY LEAVE API URL => $uri");
    print("APPLY LEAVE TOKEN => ${token.isNotEmpty ? "TOKEN OK" : "TOKEN EMPTY"}");
    print("APPLY LEAVE BODY => reason=$reason | startDate=$startDate | endDate=$endDate | days=$numberOfDays");
    print("APPLY LEAVE FILE => ${proofFile?.path ?? "NO FILE"}");

    final request = http.MultipartRequest("POST", uri);

    request.headers.addAll({
      "Authorization": "Bearer $token",
    });

    request.fields["reason"] = reason;
    request.fields["startDate"] = startDate;
    request.fields["endDate"] = endDate;
    request.fields["numberOfDays"] = numberOfDays.toString();

    if (proofFile != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          "proof",
          proofFile.path,
        ),

      );
    }

    final streamedResponse = await request.send();

    print("APPLY LEAVE STATUS CODE => ${streamedResponse.statusCode}");

    final responseBody = await streamedResponse.stream.bytesToString();
    print("APPLY LEAVE RAW RESPONSE => $responseBody");

    final decoded = jsonDecode(responseBody);

    if (streamedResponse.statusCode == 200 || streamedResponse.statusCode == 201) {
      print(" APPLY LEAVE SUCCESS (200/201) DONE");
      return ApplyLeaveResponseModel.fromJson(decoded);
    }

    final message = decoded["message"] ?? "Leave apply failed";
    print("APPLY LEAVE FAILED => $message");
    throw Exception(message);
  }
}
