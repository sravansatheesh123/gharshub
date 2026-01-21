import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:gharshub/controller/dashboard/leave_controller.dart';
import 'package:gharshub/core/app_colors.dart';
import 'package:gharshub/custom_widgets/app_button.dart';
import 'package:gharshub/custom_widgets/app_text.dart';
import 'package:gharshub/custom_widgets/app_textfield.dart';

class ApplyLeaveWidget extends StatefulWidget {
  const ApplyLeaveWidget({super.key});

  @override
  State<ApplyLeaveWidget> createState() => _ApplyLeaveWidgetState();
}

class _ApplyLeaveWidgetState extends State<ApplyLeaveWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LeaveController>(
      init: LeaveController(),
      id: 'ApplyLeaveWidget',
      builder: (controller) => Dialog(
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
                    AppText("Apply for leave", fontSize: 16, fontheight: 2),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),

                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                CustomTextField(
                  textEditingController: controller.reasonCtlr,
                  name: "Reason",
                  title: "Reason for leave",
                  isThisFieldRequired: true,
                  maxLines: 5,
                ),

                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: LeaveDateField(
                              label: "Start Date",
                              value: controller.startDateText,
                              onTap: () => controller.pickStartDate(context),
                            ),
                          ),
                          const SizedBox(width: 7),

                          Expanded(
                            child: LeaveDateField(
                              label: "End Date",
                              value: controller.endDateText,
                              onTap: () => controller.pickEndDate(context),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          AppText(
                            "Number of days",
                            fontSize: 14,
                            color: AppColors.lightgrayColor,
                          ),
                          Text(
                            "  *",
                            style: TextStyle(color: AppColors.redColor),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: controller.totalDays.value == 0
                              ? "0"
                              : controller.totalDays.value.toString(),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      width: 70,
                      textSize: 12,
                      color: AppColors.buttonColor.withOpacity(.1),
                      onTap: () {},
                      text: "Cancel",
                      textColor: AppColors.buttonColor,
                    ),
                    SizedBox(width: 10),
                    CustomButton(
                      width: 70,
                      textSize: 12,
                      onTap: () {},
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
        Text(label),
        const SizedBox(height: 6),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.lightgrayColor.withOpacity(.3),
              ),
              borderRadius: BorderRadius.circular(6),
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
