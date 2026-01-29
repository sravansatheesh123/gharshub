import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:gharshub/core/storage_keys.dart';
import 'package:gharshub/models/profile/profile_model.dart';
import 'package:gharshub/models/projects/project_model.dart';
import 'package:gharshub/services/profile/profile_service.dart';
import 'package:gharshub/services/projects/project_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProjectController extends GetxController {
  ProjectListModel? projectListModel;
  bool isLoading = false;
  setLoader(status) {
    isLoading = status;
    update();
  }

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(StorageKeys.token) ?? "";
  }

  Future<void> project() async {
    setLoader(true);
    try {
      final token = await _getToken();
      final res = await ProjectServices().project(token);
      projectListModel = res;
      setLoader(false);
      setLoader(false);
    } catch (e) {
      setLoader(false);
      Get.snackbar(
        "Punch Status",
        e.toString().replaceAll("Exception:", "").trim(),
      );
    }
  }

  @override
  void onInit() {
    project();
    super.onInit();
  }
}
