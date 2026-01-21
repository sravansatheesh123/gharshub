import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gharshub/controller/dashboard/dashboard_controller.dart';
import 'package:gharshub/custom_widgets/app_text.dart';
import '../../../core/app_colors.dart';

class AttendanceWidget extends StatelessWidget {
  AttendanceWidget({super.key});

  final DashboardController controller =
      Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 6),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              "Attendance",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 12),

            // punch in time
            AppText("Punch In : ${controller.punchInFormatted}"),
            const SizedBox(height: 12),

            // current running clock
            Row(
              children: [
                const Icon(Icons.access_time),
                const SizedBox(width: 6),
                AppText(
                  controller.currentClock,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // worked duration
            Row(
              children: [
                const Icon(Icons.timer),
                const SizedBox(width: 6),
                AppText(
                  controller.workedTime,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // punch in / out button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: controller.isPunchedIn.value
                      ? AppColors.redColor
                      : Colors.green,
                  padding:
                      const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  controller.isPunchedIn.value
                      ? controller.punchOut()
                      : controller.punchIn();
                },
                child: AppText(
                  controller.isPunchedIn.value
                      ? "PUNCH OUT"
                      : "PUNCH IN",
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
