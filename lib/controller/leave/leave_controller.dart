import 'package:get/get.dart';
import 'package:gharshub/core/storage_keys.dart';
import 'package:gharshub/models/leave/current_leave_model.dart';
import 'package:gharshub/services/leave/leave_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeavesController extends GetxController {
  CurrentLeaveModel? currentLeaveModel;
  bool isLoading = false;
  setLoader(status) {
    isLoading = status;
    update();
  }

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(StorageKeys.token) ?? "";
  }

  Future<void> currentLeave() async {
    setLoader(true);
    try {
      final token = await _getToken();
      final res = await LeaveService().currentLeaveStatus(token: token);
      currentLeaveModel = res;
      setLoader(false);
      setLoader(false);
    } catch (e) {
      setLoader(false);
      Get.snackbar(
        "Error Message",
        e.toString().replaceAll("Exception:", "").trim(),
      );
    }
  }
}
