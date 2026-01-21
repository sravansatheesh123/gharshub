import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LeaveController extends GetxController {
  TextEditingController reasonCtlr = TextEditingController();
    TextEditingController totalNumberCtlr = TextEditingController();


  Rx<DateTime?> startDate = Rx<DateTime?>(null);
  Rx<DateTime?> endDate = Rx<DateTime?>(null);
  RxInt totalDays = 0.obs;

  Future<void> pickStartDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      startDate.value = picked;
      _calculateDays();
    }
  }

  Future<void> pickEndDate(BuildContext context) async {
    if (startDate.value == null) {
      Get.snackbar("Select Start Date", "Please select start date first");
      return;
    }

    final picked = await showDatePicker(
      context: context,
      initialDate: startDate.value!,
      firstDate: startDate.value!,
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      endDate.value = picked;
      _calculateDays();
    }
  }

  void _calculateDays() {
    if (startDate.value != null && endDate.value != null) {
      totalDays.value =
          endDate.value!.difference(startDate.value!).inDays + 1;
    }
  }

  String get startDateText =>
      startDate.value == null ? "yyyy-mm-dd" : _format(startDate.value!);

  String get endDateText =>
      endDate.value == null ? "yyyy-mm-dd" : _format(endDate.value!);

  String _format(DateTime d) =>
      "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
}
