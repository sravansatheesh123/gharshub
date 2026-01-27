import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gharshub/core/app_colors.dart';
import 'package:gharshub/custom_widgets/app_button.dart';
import 'package:gharshub/custom_widgets/app_text.dart';
import 'package:gharshub/screen/salary_details/payslip_widget.dart';
import 'package:gharshub/screen/salary_details/recent_receipt_widget.dart';

import '../../controller/dashboard/dashboard_controller.dart';
import '../../controller/dashboard/timesheet/monthly_timesheet_controller.dart';

class SalaryDetailsPage extends StatelessWidget {
  SalaryDetailsPage({super.key});

  final MonthlyTimesheetController timesheetController = Get.put(
    MonthlyTimesheetController(),
  );

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      timesheetController.fetchMonthlyTimesheet();
    });

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        iconTheme: IconThemeData(color: AppColors.buttonColor),
        title: AppText(
          "Timesheet & Salary",
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.buttonColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Obx(() {
            if (timesheetController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (timesheetController.errorMessage.value.isNotEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: AppText(
                    timesheetController.errorMessage.value,
                    color: Colors.red,
                    fontSize: 14,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            final data = timesheetController.timesheetData.value;

            if (data == null) {
              return const Center(child: Text("No timesheet data found"));
            }

            final timesheetList = data.timesheet;

            final daysWorked = timesheetList
                .where((e) => e.status.toLowerCase() == "present")
                .length;

            final totalHours = timesheetList
                .map((e) => e.totalHours)
                .where((h) => h != "-" && h.isNotEmpty)
                .length;

            final monthYearText = "${_monthName(data.month)} ${data.year}";

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.lightgrayColor.withOpacity(.1),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText("Total Hours : $totalHours hrs"),
                          AppText("Days Worked : $daysWorked"),
                        ],
                      ),
                      const SizedBox(height: 10),
                      AppText("Month : $monthYearText"),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                Container(
                  height: 430,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal, // ✅ Horizontal scroll
                    child: SizedBox(
                      width:
                          650, // ✅ give fixed width for row content (adjust if needed)
                      child: ListView.builder(
                        itemCount: timesheetList.length,
                        physics:
                            const BouncingScrollPhysics(), // ✅ Vertical scroll
                        itemBuilder: (context, index) {
                          final item = timesheetList[index];
                          final dateText = _formatDate(item.date);

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 80,
                                      child: AppText(dateText),
                                    ),
                                    SizedBox(
                                      width: 90,
                                      child: AppText(
                                        item.status,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 180,
                                      child: AppText(
                                        "${item.punchIn} - ${item.punchOut}",
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 70,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: AppText(
                                          item.totalHours == "-"
                                              ? "-"
                                              : item.totalHours,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const Divider(),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.redColor.withOpacity(.1),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText("Hourly Rate : AED 25", fontheight: 2),
                      AppText("Total Hours : 128", fontheight: 2),
                      AppText("Eligible Salary : AED 3200", fontheight: 2),
                      Row(
                        children: [
                          AppText("Status :", fontheight: 2),
                          const SizedBox(width: 5),
                          AppText("Credited", color: Colors.green),
                          const Spacer(),
                          AppText(
                            "Credited Date : 13 August 2925",
                            fontheight: 2,
                          ),
                        ],
                      ),
                      AppText("Salary Acknowledgment required", fontheight: 2),
                      CustomButton(
                        onTap: () async {
                          final String currentYear = DateTime.now().year
                              .toString();

                          final dashboardController =
                              Get.isRegistered<DashboardController>()
                              ? Get.find<DashboardController>()
                              : Get.put(DashboardController(), permanent: true);

                          final String employeeId = await dashboardController
                              .getUserId();

                          if (employeeId.isEmpty) {
                            Get.snackbar(
                              "Error",
                              "User ID not found. Please login again.",
                            );
                            return;
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PayslipWidget(
                                employeeId: employeeId,
                                year: currentYear,
                              ),
                            ),
                          );
                        },
                        text: "View & Sign",
                      ),

                      SizedBox(height: 10),
                      CustomButton(onTap: () {
                        Get.to(RecentReceiptWidget());
                      }, text: "Recent Salary Details"),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    if (month < 1 || month > 12) return "-";
    return months[month - 1];
  }

  String _formatDate(String isoDate) {
    try {
      final dt = DateTime.parse(isoDate);
      return "${dt.day.toString().padLeft(2, "0")} ${_monthName(dt.month)}";
    } catch (_) {
      return isoDate;
    }
  }
}
