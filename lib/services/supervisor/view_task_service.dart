import 'dart:convert';

import 'package:gharshub/core/api_constants.dart';
import 'package:gharshub/models/supervisor/view_sub_task_model.dart';
import 'package:gharshub/models/supervisor/view_task_model.dart';
import 'package:http/http.dart' as http;

class SpvViewTaskService {
  Future<SpvViewTaskModel> viewTask(token, {projectId}) async {
    final url = Uri.parse(ApiConstants().viewTask(projectId: projectId));

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    final data = jsonDecode(response.body);

    print("Get receipt => ${response.statusCode}");
    print("Receipt data => $data");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return SpvViewTaskModel.fromJson(data);
    }
    if (response.statusCode == 404) {
      return SpvViewTaskModel.fromJson(data);
    } else {
      throw Exception("Failed to submit receipt request");
    }
  }

  Future<SpvViewSubTaskModel> viewSubTask(token, {projectId}) async {
    final url = Uri.parse(ApiConstants().viewSubTask(projectId: projectId));

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    final data = jsonDecode(response.body);

    print("Get receipt => ${response.statusCode}");
    print("Receipt data => $data");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return SpvViewSubTaskModel.fromJson(data);
    }
    if (response.statusCode == 404) {
      return SpvViewSubTaskModel.fromJson(data);
    } else {
      throw Exception("Failed to submit receipt request");
    }
  }
}
