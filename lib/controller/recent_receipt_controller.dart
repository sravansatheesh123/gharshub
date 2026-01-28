import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:gharshub/core/storage_keys.dart';
import 'package:gharshub/models/accessable_receipt_model.dart';
import 'package:gharshub/models/my_recent_receipt.dart';
import 'package:gharshub/models/my_request_model.dart';
import 'package:gharshub/models/submit_request_model.dart';
import 'package:gharshub/services/recent_receipt_service.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:month_picker_dialog/month_picker_dialog.dart';

class RecentReceiptController extends GetxController {
  RecentReceiptModel? receiptModel;
  SubmitRequestModel? submitRequestModel;
  MyRequestModel? myRequestModel;
  AccessableReceiptModel? accessableReceiptModel;
  bool isLoading = false;
  TextEditingController reasonReceiptCtlr = TextEditingController();
  setLoader(status) {
    isLoading = status;
    update();
  }

  bool isEnableRequest = false;
  setReceiptRequest(status) {
    isEnableRequest = status;
    update();
  }

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(StorageKeys.token) ?? "";
  }

  Future<void> getRecentReceipt() async {
    setLoader(true);
    try {
      final token = await _getToken();
      final res = await RecentReceiptService().getrecentReceipt(token: token);
      receiptModel = res;
      setLoader(false);
      print(res);
    } catch (e) {
      setLoader(false);
      Get.snackbar(
        "Punch Status",
        e.toString().replaceAll("Exception:", "").trim(),
      );
    }
  }

  Future<void> submitRequestReceipt() async {
    setLoader(true);
    try {
      final token = await _getToken();
      print("$selectedMonth $selectedYear ${reasonReceiptCtlr.text}");
      final res = await RecentReceiptService().submitRequestReceipt(
        token: token,
        month: selectedMonth,
        year: selectedYear,
        reason: reasonReceiptCtlr.text,
      );
      submitRequestModel = res;
      setLoader(false);
      setReceiptRequest(false);
      print(res);
      Get.snackbar("Request Status", "${submitRequestModel?.message}");
    } catch (e) {
      setLoader(false);
      Get.snackbar(
        "Punch Status",
        e.toString().replaceAll("Exception:", "").trim(),
      );
    }
  }

  Future<void> myRequest() async {
    setLoader(true);
    try {
      final token = await _getToken();
      final res = await RecentReceiptService().myRequest(token);
      myRequestModel = res;
      setLoader(false);
      setReceiptRequest(false);
    } catch (e) {
      setLoader(false);
      Get.snackbar(
        "Punch Status",
        e.toString().replaceAll("Exception:", "").trim(),
      );
    }
  }


    Future<void> accessableRequest() async {
    setLoader(true);
    try {
      final token = await _getToken();
      final res = await RecentReceiptService().accessableReceipt(token);
      accessableReceiptModel = res;
      setLoader(false);
      setReceiptRequest(false);
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
    getRecentReceipt();
    super.onInit();
  }

  String? selectedMonth;
  int selectedYear = DateTime.now().year;

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
}
