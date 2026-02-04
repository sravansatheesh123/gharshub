import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:gharshub/core/storage_keys.dart';
import 'package:gharshub/models/profile/profile_model.dart';
import 'package:gharshub/models/supervisor/finish_work_model.dart';
import 'package:gharshub/models/supervisor/profile_model.dart';
import 'package:gharshub/models/supervisor/start_work_model.dart';
import 'package:gharshub/models/supervisor/timestamp_model.dart';
import 'package:gharshub/models/supervisor/view_sub_task_model.dart';
import 'package:gharshub/models/supervisor/view_task_model.dart';
import 'package:gharshub/services/profile/profile_service.dart';
import 'package:gharshub/services/supervisor/profile_service.dart';
import 'package:gharshub/services/supervisor/view_task_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPV_ViewTaskController extends GetxController {
  SpvViewTaskModel? viewTaskModel;
  SpvViewSubTaskModel? viewSubTaskModel;
  SpvSubTaskTimestambModel? spvSubTaskTimestambModel;
  SpvFinishWorkModel? spvFinishWorkModel;
  SpvStartWorkModel? spvStartWorkModel;

  bool isLoading = false;

  setLoader(status) {
    isLoading = status;
    update();
  }

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(StorageKeys.token) ?? "";
  }

  Future<void> viewTask(projectId) async {
    setLoader(true);

    try {
      final token = await _getToken();

      final res = await SpvViewTaskService().viewTask(
        token,
        projectId: projectId,
      );

      viewTaskModel = res;

      update();

      setLoader(false);

      // Debug
      print("VIEW TASK DATA LOADED");
      print(viewTaskModel?.data?.tasks?.length);
    } catch (e) {
      setLoader(false);

      Get.snackbar(
        "Punch Status",
        e.toString().replaceAll("Exception:", "").trim(),
      );
    }
  }

  Future<void> viewSubTask(projectId) async {
    setLoader(true);

    try {
      final token = await _getToken();

      final res = await SpvViewTaskService().viewSubTask(
        token,
        projectId: projectId,
      );

      viewSubTaskModel = res;

      update();

      setLoader(false);

      // Debug
      print("VIEW SUB TASK DATA LOADED");
      print(viewSubTaskModel?.data?.subTasks?.length);
    } catch (e) {
      setLoader(false);

      Get.snackbar(
        "Punch Status",
        e.toString().replaceAll("Exception:", "").trim(),
      );
    }
  }

  Future<void> timeStamp(projectId) async {
    setLoader(true);

    try {
      final token = await _getToken();

      final res = await SpvViewTaskService().timeStamp(
        token,
        projectId: projectId,
      );

      spvSubTaskTimestambModel = res;

      update();

      setLoader(false);

      // Debug
      print("VIEW SUB TASK DATA LOADED");
      print(viewSubTaskModel?.data?.subTasks?.length);
    } catch (e) {
      setLoader(false);

      Get.snackbar(
        "Punch Status",
        e.toString().replaceAll("Exception:", "").trim(),
      );
    }
  }

  Future<void> startWork(projectId) async {
    setLoader(true);

    try {
      final token = await _getToken();

      final res = await SpvViewTaskService().startTask(
        token,
        projectId: projectId,
      );

      spvStartWorkModel = res;

      update();
      Get.snackbar("Work Status", "${spvStartWorkModel?.message}");

      setLoader(false);

      // Debug
      print("VIEW SUB TASK DATA LOADED");
      print(viewSubTaskModel?.data?.subTasks?.length);
    } catch (e) {
      setLoader(false);

      Get.snackbar(
        "Punch Status",
        e.toString().replaceAll("Exception:", "").trim(),
      );
    }
  }

  Future<void> finishWork(projectId) async {
    setLoader(true);

    try {
      final token = await _getToken();

      final res = await SpvViewTaskService().finishTask(
        token,
        projectId: projectId,
      );

      spvFinishWorkModel = res;

      update();
      Get.snackbar("Work Status", "${spvFinishWorkModel?.message}");

      setLoader(false);

      // Debug
      print("VIEW SUB TASK DATA LOADED");
      print(viewSubTaskModel?.data?.subTasks?.length);
    } catch (e) {
      setLoader(false);

      Get.snackbar(
        "Punch Status",
        e.toString().replaceAll("Exception:", "").trim(),
      );
    }
  }
}
