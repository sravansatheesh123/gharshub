import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:gharshub/core/storage_keys.dart';
import 'package:gharshub/models/profile/profile_model.dart';
import 'package:gharshub/models/supervisor/supervisor_dashboard_model.dart';
import 'package:gharshub/services/profile/profile_service.dart';
import 'package:gharshub/services/supervisor/dashboard_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends GetxController {
  SupervisorDashboardModel? supervisorDashboardModel;
  bool isLoading = false;
  setLoader(status) {
    isLoading = status;
    update();
  }

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(StorageKeys.token) ?? "";
  }

  Future<void> dashboard() async {
    setLoader(true);
    try {
      final token = await _getToken();
      final res = await SupervisorDashBoardService().dashboard(token);
      supervisorDashboardModel = res;
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
    dashboard();
    super.onInit();
  }
}
