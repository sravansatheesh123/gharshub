import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:gharshub/core/storage_keys.dart';
import 'package:gharshub/models/supervisor/project_model.dart';
import 'package:gharshub/services/supervisor/project_service.dart';

class SPV_ProjectController extends GetxController {

  SpvProjectModel? spvProjectModel;

  bool isLoading = false;
  String error = "";

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(StorageKeys.token) ?? "";
  }

  void setLoader(bool status) {
    isLoading = status;
    update();
  }

  Future<void> spvProject() async {
    try {
      setLoader(true);
      error = "";

      final token = await _getToken();

      final res = await SPVProjectService().spvProject(token);

      spvProjectModel = res;

    } catch (e) {

      error = e.toString();

      Get.snackbar(
        "Project Status",
        e.toString().replaceAll("Exception:", "").trim(),
      );

    } finally {
      setLoader(false);
    }
  }

  @override
  void onInit() {
    spvProject();
    super.onInit();
  }
}
