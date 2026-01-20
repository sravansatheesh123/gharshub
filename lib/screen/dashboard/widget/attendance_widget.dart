import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gharshub/controller/dashboard/dashboard_controller.dart';
import 'package:gharshub/custom_widgets/app_text.dart';
import '../../../core/app_colors.dart';

class AttendanceWidget extends StatelessWidget {
  AttendanceWidget({super.key});

  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText("Attendance", fontSize: 16, fontWeight: FontWeight.bold),
            const SizedBox(height: 12),

            AppText("Punch In : ${controller.punchInFormatted}"),
            const SizedBox(height: 8),

            Row(
              children: [
                const Icon(Icons.timer),
                const SizedBox(width: 6),
                AppText(
                  controller.liveTime,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.isPunchedIn.value
                          ? AppColors.redColor
                          : Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      controller.isPunchedIn.value
                          ? controller.punchOut()
                          : controller.punchIn();
                    },
                    child: AppText(
                      controller.isPunchedIn.value ? "PUNCH OUT" : "PUNCH IN",
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
