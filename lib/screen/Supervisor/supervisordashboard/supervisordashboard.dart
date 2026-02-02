import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gharshub/core/app_colors.dart';
import 'package:gharshub/custom_widgets/app_bar.dart';
import 'package:gharshub/custom_widgets/app_button.dart';
import 'package:gharshub/custom_widgets/app_text.dart';
import 'package:gharshub/screen/Supervisor/make_attendance/make_attendance_page.dart';
import 'package:gharshub/screen/Supervisor/project/project.dart';
import 'package:gharshub/screen/projects/projects_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controller/supervisor/supervisor_dashboard_controller.dart';
import '../../auth/login_page.dart';

class SupervisorDashboard extends StatelessWidget {
  const SupervisorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final SupervisorDashboardController controller = Get.put(
      SupervisorDashboardController(),
    );
    return Scaffold(
      backgroundColor: AppColors.skyColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(85),
        child: SuperVisorAppBar(
          onTapLogout: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.clear();
            if (Get.isRegistered<SupervisorDashboardController>()) {
              Get.delete<SupervisorDashboardController>(force: true);
            }
            Get.offAll(() => LoginPage());
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.error.value.isNotEmpty) {
                  return Center(child: Text(controller.error.value));
                }

                return const SizedBox();
              }),
              AppText(
                "DashBoard",
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontheight: 3,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blackColor.withOpacity(0.08),
                      blurRadius: 12,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Obx(
                          () => _reusableExpanedWidget(
                            "Total Assigned",
                            controller.totalAssigned.value.toString(),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Obx(
                          () => _reusableExpanedWidget(
                            "Present",
                            controller.present.value.toString(),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Obx(
                          () => _reusableExpanedWidget(
                            "Absent",
                            controller.absent.value.toString(),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Obx(
                          () => _reusableExpanedWidget(
                            "StandBy",
                            controller.standby.value.toString(),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 7),
                    CustomButton(
                      onTap: () => Get.to(() => MakeAttendancePage()),
                      text: "Mark Attendance",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blackColor.withOpacity(0.08),
                      blurRadius: 12,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      "Assigned Project",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontheight: 1,
                    ),
                    Obx(
                      () => AppText(
                        "Total Project : ${controller.totalProjects.value}",
                        fontheight: 2,
                      ),
                    ),

                    const SizedBox(height: 7),
                    _reusableListtile("Project Alpha", "On Track", 80),
                    const SizedBox(height: 7),
                    _reusableListtile(
                      "Project Beta",
                      "Delayed",
                      45,
                      color: Colors.orange.shade300,
                    ),
                    const SizedBox(height: 7),
                    CustomButton(
                      onTap: () => Get.to(() => SPV_ProjectsPage()),
                      text: "View Projects",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Alerts
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blackColor.withOpacity(0.08),
                      blurRadius: 12,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      "Alert & Attention",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontheight: 1,
                    ),
                    const SizedBox(height: 7),
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColors.lightRedColor,
                      ),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: AppText(
                        "2 task delayed",
                        color: AppColors.redColor,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColors.lightRedColor,
                      ),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: AppText(
                        "3 team members absent today",
                        color: AppColors.redColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _reusableExpanedWidget(String title, String value) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.skyColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            AppText(title, fontWeight: FontWeight.bold),
            AppText(value, fontWeight: FontWeight.normal, fontheight: 2),
          ],
        ),
      ),
    );
  }

  Widget _reusableListtile(
    String title,
    String status,
    int value, {
    Color? color,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 0),
      leading: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(title, fontheight: 1, fontWeight: FontWeight.bold),
          const SizedBox(height: 7),
          Container(
            width: 100,
            decoration: BoxDecoration(
              color: color ?? AppColors.lightGreenColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Center(child: AppText(status, fontSize: 10)),
          ),
        ],
      ),
      trailing: SizedBox(
        width: 100,
        child: LinearProgressIndicator(
          value: value / 100,
          color: color ?? Colors.green,
        ),
      ),
    );
  }
}
