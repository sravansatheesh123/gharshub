import 'package:gharshub/core/api_constants.dart';
import 'package:http/http.dart' as HttpService;

import '../../../models/supervisor/subtask/start_finish_model.dart';


class SubTaskService {

  Future<StartFinishResponse?> startWork(String id) async {
    final response = await HttpService.post(
      ApiConstants.startSubTask(id),
      {},
    );

    if (response != null) {
      return StartFinishResponse.fromJson(response);
    }
    return null;
  }

  Future<StartFinishResponse?> finishWork(String id) async {
    final response = await HttpService.post(
      ApiConstants.finishSubTask(id),
      {},
    );

    if (response != null) {
      return StartFinishResponse.fromJson(response);
    }
    return null;
  }
}
