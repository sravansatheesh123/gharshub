import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:gharshub/core/storage_keys.dart';
import 'package:gharshub/models/recent_receipt.dart';
import 'package:gharshub/services/recent_receipt_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentReceiptController extends GetxController {
  RecentReceiptModel? receiptModel;
  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(StorageKeys.token) ?? "";
  }

  Future<void> getRecentReceipt() async {
    try {
      final token = await _getToken();
      final res = await RecentReceiptService().getrecentReceipt(token: token);
      receiptModel = res;
      print(res);
    } catch (e) {
      Get.snackbar(
        "Punch Status",
        e.toString().replaceAll("Exception:", "").trim(),
      );
    }
  }

  @override
  void onInit() {
    getRecentReceipt();
    super.onInit();
  }
}
