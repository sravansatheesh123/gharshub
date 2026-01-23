import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gharshub/core/storage_keys.dart';
import 'package:gharshub/models/timesheet/monthly_timesheet_model.dart';
import 'package:gharshub/services/timesheet/monthly_timesheet_service.dart';

class MonthlyTimesheetController extends GetxController {
  final MonthlyTimesheetService _service = MonthlyTimesheetService();

  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;

  Rxn<MonthlyTimesheetData> timesheetData = Rxn<MonthlyTimesheetData>();

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(StorageKeys.token) ?? "";
  }

  Future<void> fetchMonthlyTimesheet() async {
    try {
      isLoading.value = true;
      errorMessage.value = "";
      timesheetData.value = null;

      final token = await _getToken();

      if (token.isEmpty) {
        errorMessage.value = "Token missing. Please login again.";
        return;
      }

      final response = await _service.getMonthlyTimesheet(token: token);

      if (response["success"] == true) {
        final parsed = MonthlyTimesheetResponse.fromJson(response);
        timesheetData.value = parsed.data;
      } else {
        errorMessage.value = response["error"]?.toString() ?? "No timesheet found";
      }
    } catch (e) {
      final msg = e.toString();

      if (msg.contains("403")) {
        errorMessage.value = "You are not authorized to view timesheet.";
      } else {
        errorMessage.value = msg.replaceAll("Exception:", "").trim();
      }
    } finally {
      isLoading.value = false;
    }
  }
}
