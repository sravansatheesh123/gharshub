import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gharshub/controller/dashboard/leave_controller.dart';
import 'package:gharshub/core/app_colors.dart';
import 'package:gharshub/custom_widgets/app_button.dart';
import 'package:gharshub/custom_widgets/app_text.dart';
import 'package:gharshub/custom_widgets/app_textfield.dart';

class ApplyLeaveWidget extends StatelessWidget {
  const ApplyLeaveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LeaveController>(
      init: LeaveController(),
      builder: (controller) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        insetPadding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText("Apply for Leave",
                        fontSize: 16, fontWeight: FontWeight.bold),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),

                CustomTextField(
                  textEditingController: controller.reasonCtlr,
                  name: "Reason",
                  title: "Reason for Leave",
                  isThisFieldRequired: true,
                  maxLines: 4,
                ),

                const SizedBox(height: 14),

                Obx(
                      () => Row(
                    children: [
                      Expanded(
                        child: LeaveDateField(
                          label: "Start Date",
                          value: controller.startDateText,
                          onTap: () => controller.pickStartDate(context),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: LeaveDateField(
                          label: "End Date",
                          value: controller.endDateText,
                          onTap: () => controller.pickEndDate(context),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                AppText("Number of Days",
                    fontSize: 14, color: Colors.black54),
                const SizedBox(height: 6),
                Obx(
                      () => TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: controller.totalDays.value == 0
                          ? "0"
                          : controller.totalDays.value.toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 14),


                AppText("Upload Leave Proof",
                    fontSize: 14, color: Colors.black54),
                const SizedBox(height: 6),

                Obx(
                      () => InkWell(
                    onTap: controller.pickProofDialog,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 14),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.lightgrayColor.withOpacity(.3),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: AppColors.lightgrayColor
                                      .withOpacity(.4)),
                              color: Colors.white,
                            ),
                            child: const Text("Choose File"),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              controller.proofName.value.isEmpty
                                  ? "No file chosen"
                                  : controller.proofName.value,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      width: 120,
                      textSize: 13,
                      color: Colors.grey.shade200,
                      onTap: () => Get.back(),
                      text: "Cancel",
                      textColor: Colors.black87,
                    ),
                    const SizedBox(width: 10),
                    CustomButton(
                      width: 160,
                      textSize: 13,
                      onTap: () {
                        controller.submitLeave();
                      },
                      text: "Submit Application",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LeaveDateField extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const LeaveDateField({
    super.key,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.black54)),
        const SizedBox(height: 6),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.lightgrayColor.withOpacity(.3),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(value), const Icon(Icons.calendar_month)],
            ),
          ),
        ),
      ],
    );
  }
}
