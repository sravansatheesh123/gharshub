import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gharshub/core/api_constants.dart';
import 'package:gharshub/models/supervisor/view_task_model.dart';
import 'package:gharshub/models/supervisor/view_sub_task_model.dart';

class SpvViewTaskService {

  // --------------------------------------------------
  // VIEW TASK LIST
  // --------------------------------------------------
  Future<SpvViewTaskModel> viewTask(String token, {required projectId}) async {

    final url = Uri.parse(ApiConstants().viewTask(projectId: projectId));

    final res = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
    );

    final data = jsonDecode(res.body);

    if (res.statusCode == 200) {
      return SpvViewTaskModel.fromJson(data);
    } else {
      throw Exception(data["message"] ?? "Failed to load tasks");
    }
  }

  // --------------------------------------------------
  // VIEW SUB TASK
  // --------------------------------------------------
  Future<SpvViewSubTaskModel> viewSubTask(String token, {required projectId}) async {

    final url = Uri.parse(ApiConstants().viewSubTask(projectId: projectId));

    final res = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
    );

    final data = jsonDecode(res.body);

    if (res.statusCode == 200) {
      return SpvViewSubTaskModel.fromJson(data);
    } else {
      throw Exception(data["message"] ?? "Failed to load sub tasks");
    }
  }

  // --------------------------------------------------
  // START WORK (POST)
  // --------------------------------------------------
  Future<dynamic> startSubTask(String token, String subInquiryId) async {

    final url = Uri.parse(ApiConstants.startSubTask(subInquiryId));

    final res = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
    );

    final data = jsonDecode(res.body);

    if (res.statusCode == 200 && data["success"] == true) {
      return data;
    } else {
      throw Exception(data["message"] ?? "Failed to start work");
    }
  }

  // --------------------------------------------------
  // FINISH WORK (POST)
  // --------------------------------------------------
  Future<dynamic> finishSubTask(String token, String subInquiryId) async {

    final url = Uri.parse(ApiConstants.finishSubTask(subInquiryId));

    final res = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
    );

    final data = jsonDecode(res.body);

    if (res.statusCode == 200 && data["success"] == true) {
      return data;
    } else {
      throw Exception(data["message"] ?? "Failed to finish work");
    }
  }

  // --------------------------------------------------
// START MAIN TASK
// --------------------------------------------------
  Future<dynamic> startTask(String token, String inquiryId) async {

    final url = Uri.parse(ApiConstants.startTask(inquiryId));

    final res = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
    );

    final data = jsonDecode(res.body);

    if (res.statusCode == 200 && data["success"] == true) {
      return data;
    } else {
      throw Exception(data["message"] ?? "Failed to start task");
    }
  }

// --------------------------------------------------
// FINISH MAIN TASK
// --------------------------------------------------
  Future<dynamic> finishTask(String token, String inquiryId) async {

    final url = Uri.parse(ApiConstants.finishTask(inquiryId));

    final res = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
    );

    final data = jsonDecode(res.body);

    if (res.statusCode == 200 && data["success"] == true) {
      return data;
    } else {
      throw Exception(data["message"] ?? "Failed to finish task");
    }
  }

}
