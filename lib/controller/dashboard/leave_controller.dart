import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/storage_keys.dart';
import '../../models/leave/apply_leave_model.dart';
import '../../services/leave/apply_leave_service.dart';
import '../dashboard/dashboard_controller.dart';

class LeaveController extends GetxController {
  final ApplyLeaveService _applyLeaveService = ApplyLeaveService();

  TextEditingController reasonCtlr = TextEditingController();

  Rx<DateTime?> startDate = Rx<DateTime?>(null);
  Rx<DateTime?> endDate = Rx<DateTime?>(null);
  RxInt totalDays = 0.obs;

  // upload proof
  RxString proofName = "".obs;
  File? proofFile;

  RxBool isSubmitting = false.obs;

  /// Local duplicate validation (only works until app restart)
  final List<Map<String, DateTime>> appliedRanges = [];

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(StorageKeys.token) ?? "";
  }

  // ================= DATE PICKERS =================

  Future<void> pickStartDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      startDate.value = picked;

      // reset end date if end is before start
      if (endDate.value != null && endDate.value!.isBefore(picked)) {
        endDate.value = null;
      }

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
      totalDays.value = endDate.value!.difference(startDate.value!).inDays + 1;
    } else {
      totalDays.value = 0;
    }
  }

  // ================= FILE PICK =================

  void pickProofDialog() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Choose from Gallery"),
              onTap: () async {
                Get.back();
                await pickProofFromGallery();
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_file),
              title: const Text("Choose File"),
              onTap: () async {
                Get.back();
                await pickProofFromFiles();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickProofFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? img = await picker.pickImage(source: ImageSource.gallery);

    if (img != null) {
      proofFile = File(img.path);
      proofName.value = img.name;
    }
  }

  Future<void> pickProofFromFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      proofFile = File(result.files.single.path!);
      proofName.value = result.files.single.name;
    }
  }

  // ================= HELPERS =================

  String _formatApiDate(DateTime d) {
    return "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
  }

  DateTime _onlyDate(DateTime d) => DateTime(d.year, d.month, d.day);

  bool _isOverlapping(
      DateTime aStart,
      DateTime aEnd,
      DateTime bStart,
      DateTime bEnd,
      ) {
    // overlap condition: start <= otherEnd && end >= otherStart
    return !aStart.isAfter(bEnd) && !aEnd.isBefore(bStart);
  }

  bool _alreadyAppliedForRange(DateTime newStart, DateTime newEnd) {
    for (final range in appliedRanges) {
      final s = range["start"]!;
      final e = range["end"]!;
      if (_isOverlapping(newStart, newEnd, s, e)) {
        return true;
      }
    }
    return false;
  }

  String get startDateText =>
      startDate.value == null ? "mm/dd/yyyy" : _formatUiDate(startDate.value!);

  String get endDateText =>
      endDate.value == null ? "mm/dd/yyyy" : _formatUiDate(endDate.value!);

  String _formatUiDate(DateTime d) =>
      "${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}/${d.year}";

  // ================= SUBMIT API =================

  Future<void> submitLeave() async {
    final reason = reasonCtlr.text.trim();

    if (reason.isEmpty) {
      Get.snackbar("Required", "Please enter reason");
      return;
    }

    if (startDate.value == null) {
      Get.snackbar("Required", "Please select start date");
      return;
    }

    if (endDate.value == null) {
      Get.snackbar("Required", "Please select end date");
      return;
    }

    if (totalDays.value <= 0) {
      Get.snackbar("Required", "Invalid number of days");
      return;
    }

    final DateTime newStart = _onlyDate(startDate.value!);
    final DateTime newEnd = _onlyDate(endDate.value!);

    // Local duplicate validation
    if (_alreadyAppliedForRange(newStart, newEnd)) {
      Get.snackbar("Not Allowed", "Leave already applied on this date");
      return;
    }

    try {
      isSubmitting.value = true;

      final token = await _getToken();
      if (token.isEmpty) {
        Get.snackbar("Error", "Token missing. Please login again.");
        return;
      }

      print("APPLY LEAVE SUBMIT CLICKED");
      print("APPLY LEAVE REASON => $reason");
      print("APPLY LEAVE START => ${_formatApiDate(newStart)}");
      print("APPLY LEAVE END => ${_formatApiDate(newEnd)}");
      print("APPLY LEAVE DAYS => ${totalDays.value}");
      print("APPLY LEAVE FILE => ${proofFile?.path ?? "NO FILE"}");

      final ApplyLeaveResponseModel res = await _applyLeaveService.applyLeave(
        token: token,
        reason: reason,
        startDate: _formatApiDate(newStart),
        endDate: _formatApiDate(newEnd),
        numberOfDays: totalDays.value,
        proofFile: proofFile,
      );

      print("APPLY LEAVE SUCCESS RESPONSE => ${res.message}");

      // Save local range to prevent duplicates
      appliedRanges.add({"start": newStart, "end": newEnd});

      // Close dialog first
      Get.back();

      // Show success
      Get.snackbar(
        "Success",
        res.message ?? "Leave applied",
        snackPosition: SnackPosition.BOTTOM,
      );

      // Reset form
      reasonCtlr.clear();
      startDate.value = null;
      endDate.value = null;
      totalDays.value = 0;
      proofFile = null;
      proofName.value = "";

      if (Get.isRegistered<DashboardController>()) {
        await Get.find<DashboardController>().fetchLatestLeaveNotification();
      }
    } catch (e) {
      print("APPLY LEAVE ERROR => $e");
      Get.snackbar("Failed", e.toString().replaceAll("Exception:", "").trim());
    } finally {
      isSubmitting.value = false;
    }
  }

  @override
  void onClose() {
    reasonCtlr.dispose();
    super.onClose();
  }
}
