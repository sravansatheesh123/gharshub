import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gharshub/core/app_colors.dart';
import 'package:gharshub/custom_widgets/app_button.dart';
import 'package:gharshub/custom_widgets/app_text.dart';
import 'package:gharshub/screen/dashboard/widget/apply_leave_widget.dart';
import 'package:gharshub/screen/dashboard/widget/attendance_widget.dart';
import 'package:gharshub/screen/dashboard/widget/dashboard_appbar.dart';
import 'package:gharshub/screen/dashboard/widget/dashborad_widget.dart';
import 'package:gharshub/screen/salary_details/salary_details_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/dashboard/dashboard_controller.dart';
import '../../core/storage_keys.dart';
import '../auth/login_page.dart';

class DashboardPage extends StatelessWidget {
   DashboardPage({super.key});
  final DashboardController dashboardController = Get.put(DashboardController());

  Future<Map<String, String>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      "name": prefs.getString(StorageKeys.name) ?? "",
      "username": prefs.getString(StorageKeys.username) ?? "",
      "role": prefs.getString(StorageKeys.role) ?? "",
      "token": prefs.getString(StorageKeys.token) ?? "",
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(85),
        child: Obx(
              () => DashboardAppBar(
            notificationCount: dashboardController.notificationCount.value,
            onTapNotification: () {
              dashboardController.openNotificationPopup();
            },
            onTapLogout: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();

              if (Get.isRegistered<DashboardController>()) {
                Get.delete<DashboardController>(force: true);
              }

              Get.offAll(() => LoginPage());
            },
          ),
        ),
      ),

      body: FutureBuilder(
        future: getUserData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text("Name: ${data["name"]}",
                  //     style: const TextStyle(fontSize: 16)),
                  // const SizedBox(height: 8),
                  // Text("Username: ${data["username"]}",
                  //     style: const TextStyle(fontSize: 16)),
                  // const SizedBox(height: 8),
                  // Text("Role: ${data["role"]}",
                  //     style: const TextStyle(fontSize: 16)),
                  // const SizedBox(height: 12),
                  // const Text("Token:",
                  //     style:
                  //     TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  // const SizedBox(height: 6),
                  // Text(
                  //   data["token"] ?? "",
                  //   style: const TextStyle(fontSize: 12),
                  // ),
                  DashBoardWidget(
                    title: "Work Summary",
                    subTitle: "Total Hours Worked  : ",
                    subTitleValue: "128",
                    isEnable: true,
                    widget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        reusableRowTile("Days Worked : ", "18"),
                        AppText(
                          "Auto calculated from timesheet",
                          fontheight: 2,
                          color: AppColors.lightgrayColor,
                          fontSize: 10,
                        ),
                      ],
                    ),
                  ),

                  DashBoardWidget(
                    title: "Salary Snapshot",
                    subTitle: "Hourly Rate  : ",
                    subTitleValue: "AED 25",
                    isEnable: true,
                    widget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        reusableRowTile("Eligible Salary : ", "AED 3200"),
                        AppText(
                          "Status : Pending",
                          fontheight: 2,
                          color: AppColors.buttonColor,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomButton(
                            onTap: () {
                              Get.to(SalaryDetailsPage());
                            },
                            text: "View Salary Details",
                          ),
                        ),
                      ],
                    ),
                  ),

                  DashBoardWidget(
                    title: "My Task",
                    subTitle: "Assigned Tasks  : ",
                    subTitleValue: "3",
                    isEnable: true,
                    widget: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 28.0),
                          child: Column(
                            children: [
                              reusableRowTile("TASK 123 - ", 'In Progress'),
                              reusableRowTile("TASK 234 - ", 'In Progress'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomButton(onTap: () {}, text: "View Task"),
                        ),
                      ],
                    ),
                  ),

                  DashBoardWidget(
                    title: "Pending Actions",
                    widget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 28.0),
                          child: Column(
                            children: [
                              reusableRowTile("Salary slip to signin ", ''),
                              reusableRowTile("Policy Acknowledgment", ''),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomButton(
                            onTap: () {},
                            text: "View Notification",
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                  DashBoardWidget(
                    title: "Leave",
                    widget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 28.0),
                          child: Column(
                            children: [reusableRowTile("Leave Balance ", '6')],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomButton(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) => const ApplyLeaveWidget(),
                              );
                            },
                            text: "Apply Leave",
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 15),
                  AttendanceWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
