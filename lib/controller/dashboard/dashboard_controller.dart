import 'dart:async';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxBool isPunchedIn = false.obs;

  Rx<DateTime?> punchInTime = Rx<DateTime?>(null);
  Rx<DateTime?> punchOutDate = Rx<DateTime?>(null);

  Rx<Duration> workedDuration = Duration.zero.obs;
  Rx<Duration> totalWorkedDuration = Duration.zero.obs;

  Timer? _timer;

  bool get isTodayAlreadyCompleted {
    if (punchOutDate.value == null) return false;

    final today = DateTime.now();
    final out = punchOutDate.value!;

    return today.year == out.year &&
        today.month == out.month &&
        today.day == out.day;
  }

  void punchIn() {
    if (isTodayAlreadyCompleted) {
      Get.snackbar(
        "Not Allowed",
        "You have already completed attendance for today",
      );
      return;
    }

    punchInTime.value = DateTime.now();
    isPunchedIn.value = true;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      workedDuration.value =
          DateTime.now().difference(punchInTime.value!);
    });
  }

  void punchOut() {
    _timer?.cancel();

    totalWorkedDuration.value = workedDuration.value;
    punchOutDate.value = DateTime.now();

    isPunchedIn.value = false;
  }

  String get liveTime {
    final d =
        isPunchedIn.value ? workedDuration.value : totalWorkedDuration.value;

    return "${d.inHours.toString().padLeft(2, '0')}:"
        "${(d.inMinutes % 60).toString().padLeft(2, '0')}:"
        "${(d.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  String get punchInFormatted {
    if (punchInTime.value == null) return "--:--";
    final t = punchInTime.value!;
    return "${t.hour.toString().padLeft(2, '0')}:"
        "${t.minute.toString().padLeft(2, '0')} ${t.hour >= 12 ? "PM" : "AM"}";
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
