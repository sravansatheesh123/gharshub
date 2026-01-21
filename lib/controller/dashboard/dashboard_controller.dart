import 'dart:async';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxBool isPunchedIn = false.obs;

  Rx<DateTime?> punchInTime = Rx<DateTime?>(null);
  Rx<DateTime?> punchOutDate = Rx<DateTime?>(null);

  Rx<Duration> workedDuration = Duration.zero.obs;
  Rx<Duration> totalWorkedDuration = Duration.zero.obs;

  // current running clock
  Rx<DateTime> currentTime = DateTime.now().obs;

  Timer? _workTimer;
  Timer? _clockTimer;

  @override
  void onInit() {
    super.onInit();
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      currentTime.value = DateTime.now();
      if (isPunchedIn.value) {
        punchInTime.refresh();
      }
    });
  }

  void punchIn() {
    punchInTime.value = DateTime.now();
    isPunchedIn.value = true;

    _workTimer?.cancel();
    _workTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      workedDuration.value =
          DateTime.now().difference(punchInTime.value!);
    });
  }

  void punchOut() {
    _workTimer?.cancel();
    totalWorkedDuration.value = workedDuration.value;
    punchOutDate.value = DateTime.now();
    isPunchedIn.value = false;
  }

  //  WORKED TIME → HH:MM:SS (seconds always running)
  String get workedTime {
    final d =
        isPunchedIn.value ? workedDuration.value : totalWorkedDuration.value;

    return "${d.inHours.toString().padLeft(2, '0')}:"
        "${(d.inMinutes % 60).toString().padLeft(2, '0')}:"
        "${(d.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  //  CURRENT LIVE CLOCK → HH:MM:SS
  String get currentClock {
    final t = currentTime.value;
    return "${t.hour.toString().padLeft(2, '0')}:"
        "${t.minute.toString().padLeft(2, '0')}:"
        "${t.second.toString().padLeft(2, '0')}";
  }

  //  PUNCH IN TIME → HH:MM:SS AM/PM
  String get punchInFormatted {
    if (punchInTime.value == null) return "--:--:--";
    final t = punchInTime.value!;
    return "${t.hour.toString().padLeft(2, '0')}:"
        "${t.minute.toString().padLeft(2, '0')}:"
        "${t.second.toString().padLeft(2, '0')} "
        "${t.hour >= 12 ? "PM" : "AM"}";
  }

  @override
  void onClose() {
    _workTimer?.cancel();
    _clockTimer?.cancel();
    super.onClose();
  }
}
