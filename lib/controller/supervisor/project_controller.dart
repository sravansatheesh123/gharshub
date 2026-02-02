import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:gharshub/core/storage_keys.dart';
import 'package:gharshub/models/profile/profile_model.dart';
import 'package:gharshub/models/supervisor/profile_model.dart';
import 'package:gharshub/models/supervisor/project_model.dart';
import 'package:gharshub/services/profile/profile_service.dart';
import 'package:gharshub/services/supervisor/profile_service.dart';
import 'package:gharshub/services/supervisor/project_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class SPV_ProjectController extends GetxController {
  SpvProjectModel? spvProjectModel;
  bool isLoading = false;
  setLoader(status) {
    isLoading = status;
    update();
  }

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(StorageKeys.token) ?? "";
  }

  Future<void> spvProject() async {
    setLoader(true);
    try {
      setLoader(false);
      final token = await _getToken();
      final res = await SPVProjectService().spvProject(token);
      spvProjectModel = res;
      setLoader(false);
    } catch (e) {
      setLoader(false);
      Get.snackbar(
        "Punch Status",
        e.toString().replaceAll("Exception:", "").trim(),
      );
    }
    setLoader(false);
  }

  @override
  void onInit() {
    spvProject();
    super.onInit();
  }
}
