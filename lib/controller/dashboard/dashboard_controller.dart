import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/storage_keys.dart';
import '../../models/leave/latest_leave_model.dart';
import '../../models/punch/punch_toggle_model.dart';
import '../../services/leave/leave_service.dart';
import '../../services/punch/PunchService.dart';

class DashboardController extends GetxController {
  final PunchService _punchService = PunchService();
  final LeaveService _leaveService = LeaveService();

  RxString currentTime = "--:--:--".obs;
  Timer? _clockTimer;

  RxBool isPunchedIn = false.obs;
  Rx<DateTime?> punchInTime = Rx<DateTime?>(null);
  Rx<DateTime?> punchOutTime = Rx<DateTime?>(null);

  Rx<Duration> workedDuration = Duration.zero.obs;
  Rx<Duration> totalWorkedDuration = Duration.zero.obs;

  RxBool isLoading = false.obs;
  Timer? _timer;

  RxInt notificationCount = 0.obs;
  Rx<LeaveModel?> latestLeave = Rx<LeaveModel?>(null);

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(StorageKeys.token) ?? "";
  }

  bool get isTodayAlreadyCompleted {
    if (punchOutTime.value == null) return false;

    final today = DateTime.now();
    final out = punchOutTime.value!;

    return today.year == out.year &&
        today.month == out.month &&
        today.day == out.day;
  }
  void _startCurrentClock() {
    _clockTimer?.cancel();

    _clockTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      currentTime.value = DateFormat("HH:mm:ss").format(DateTime.now());
    });
  }

  Future<void> fetchTodayPunch() async {
    try {
      final token = await _getToken();
      if (token.isEmpty) {
        _resetAttendance();
        return;
      }

      final res = await _punchService.getTodayPunch(token: token);

      // No punch today
      if (res.punch == null) {
        _resetAttendance();
        return;
      }

      final punch = res.punch!;

      // Convert UTC -> Local
      punchInTime.value =
      punch.inTime != null ? DateTime.parse(punch.inTime!).toLocal() : null;

      punchOutTime.value = punch.outTime != null
          ? DateTime.parse(punch.outTime!).toLocal()
          : null;

      if (punchInTime.value != null && punchOutTime.value == null) {
        // still punched in
        isPunchedIn.value = true;
        totalWorkedDuration.value = Duration.zero;
        _startLiveTimer();
      } else {
        // punched out already
        isPunchedIn.value = false;
        _timer?.cancel();

        final minutes = punch.durationMinutes ?? 0;
        totalWorkedDuration.value = Duration(minutes: minutes);
        workedDuration.value = Duration.zero;
      }
    } catch (e) {
      Get.snackbar(
        "Punch Status",
        e.toString().replaceAll("Exception:", "").trim(),
      );
    }
  }

  Future<void> punchIn() async {
    if (isTodayAlreadyCompleted) {
      Get.snackbar(
        "Not Allowed",
        "You have already completed attendance for today",
      );
      return;
    }

    try {
      isLoading.value = true;

      final token = await _getToken();
      if (token.isEmpty) {
        Get.snackbar("Error", "Token missing. Please login again.");
        return;
      }

      final res = await _punchService.togglePunch(token: token, action: "in");

      if (res.status == "in" && res.punch?.inTime != null) {
        punchInTime.value = DateTime.parse(res.punch!.inTime!).toLocal();
        punchOutTime.value = null;

        isPunchedIn.value = true;
        workedDuration.value = Duration.zero;
        totalWorkedDuration.value = Duration.zero;

        _startLiveTimer();

        Get.snackbar("Success", res.message ?? "Punched in successfully");
      } else {
        Get.snackbar("Error", res.message ?? "Punch in failed");
      }
    } catch (e) {
      Get.snackbar(
        "Punch Failed",
        e.toString().replaceAll("Exception:", "").trim(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> punchOut() async {
    try {
      isLoading.value = true;

      final token = await _getToken();
      if (token.isEmpty) {
        Get.snackbar("Error", "Token missing. Please login again.");
        return;
      }

      final res = await _punchService.togglePunch(token: token, action: "out");

      if (res.status == "out") {
        _timer?.cancel();

        punchOutTime.value = res.punch?.outTime != null
            ? DateTime.parse(res.punch!.outTime!).toLocal()
            : DateTime.now();

        totalWorkedDuration.value = workedDuration.value;
        isPunchedIn.value = false;

        Get.snackbar("Success", res.message ?? "Punched out successfully");
      } else {
        Get.snackbar("Error", res.message ?? "Punch out failed");
      }
    } catch (e) {
      Get.snackbar(
        "Punch Failed",
        e.toString().replaceAll("Exception:", "").trim(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _startLiveTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (punchInTime.value != null) {
        workedDuration.value = DateTime.now().difference(punchInTime.value!);
      }
    });
  }

  void _resetAttendance() {
    isPunchedIn.value = false;
    punchInTime.value = null;
    punchOutTime.value = null;
    workedDuration.value = Duration.zero;
    totalWorkedDuration.value = Duration.zero;
    _timer?.cancel();
  }

  String get liveTime {
    final d = isPunchedIn.value ? workedDuration.value : totalWorkedDuration.value;

    return "${d.inHours.toString().padLeft(2, '0')}:"
        "${(d.inMinutes % 60).toString().padLeft(2, '0')}:"
        "${(d.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  String get punchInFormatted {
    if (punchInTime.value == null) return "--:--";
    return DateFormat("hh:mm a").format(punchInTime.value!);
  }

  String get punchOutFormatted {
    if (punchOutTime.value == null) return "--:--";
    return DateFormat("hh:mm a").format(punchOutTime.value!);
  }

  Future<void> fetchLatestLeaveNotification() async {
    try {
      final token = await _getToken();

      print("LATEST LEAVE TOKEN => $token");

      if (token.isEmpty) {
        latestLeave.value = null;
        notificationCount.value = 0;
        return;
      }

      final res = await _leaveService.getLatestLeave(token: token);

      print("LATEST LEAVE RESPONSE => ${res.leave}");

      if (res.leave != null) {
        latestLeave.value = res.leave;
        notificationCount.value = 1;
      } else {
        latestLeave.value = null;
        notificationCount.value = 0;
      }
    } catch (e) {
      print("LATEST LEAVE ERROR => $e");
      latestLeave.value = null;
      notificationCount.value = 0;
    }
  }


  void openNotificationPopup() {
    if (latestLeave.value == null) {
      Get.snackbar("Notification", "No new notifications");
      return;
    }

    final leave = latestLeave.value!;

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Notifications",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Leave ${leave.status ?? ""}".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Updated: ${leave.updatedAt ?? "-"}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    notificationCount.value = 0;
                    latestLeave.value = null;
                    Get.back();
                  },
                  child: const Text("OK"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    fetchTodayPunch();
    fetchLatestLeaveNotification();
    _startCurrentClock();
  }

  @override
  void onClose() {
    _timer?.cancel();
    _clockTimer?.cancel();
    super.onClose();
  }
}
