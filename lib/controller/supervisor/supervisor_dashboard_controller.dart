import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/storage_keys.dart';
import '../../models/supervisor/supervisor_dashboard_model.dart';
import '../../services/supervisor/supervisor_service.dart';

class SupervisorDashboardController extends GetxController {
  RxBool isLoading = false.obs;
  RxString error = "".obs;

  Rx<SupervisorDashboardModel?> dashboard = Rx<SupervisorDashboardModel?>(null);

  // easy values for UI
  RxInt totalAssigned = 0.obs;
  RxInt present = 0.obs;
  RxInt absent = 0.obs;
  RxInt standby = 0.obs;

  RxInt totalProjects = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboard();
  }

  Future<void> fetchDashboard() async {
    try {
      isLoading.value = true;
      error.value = "";
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(StorageKeys.token);

      print("TOKEN FROM PREF (Supervisor Dashboard) => $token");

      if (token == null || token.isEmpty) {
        throw Exception("Token not found. Please login again.");
      }

      final res = await SupervisorService.getDashboardSummary();
      dashboard.value = res;
      totalAssigned.value = res.data.stats.totalAssigned;
      present.value = res.data.stats.present;
      absent.value = res.data.stats.absent;
      standby.value = res.data.stats.notMarked;
      totalProjects.value = res.data.stats.totalProjects;
    } catch (e) {
      error.value = e.toString().replaceAll("Exception:", "").trim();
      print("DASHBOARD ERROR => ${error.value}");
    } finally {
      isLoading.value = false;
    }
  }
}
