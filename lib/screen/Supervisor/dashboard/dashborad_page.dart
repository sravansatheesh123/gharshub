import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gharshub/core/app_colors.dart';
import 'package:gharshub/custom_widgets/app_button.dart';
import 'package:gharshub/custom_widgets/app_text.dart';
import 'package:gharshub/screen/Supervisor/make_attendance/make_attendance_page.dart';
import 'package:gharshub/screen/Supervisor/projects/projects_page.dart';

class DashboradPage extends StatelessWidget {
  const DashboradPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.skyColor,
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(radius: 40),
        ),
        title: AppText("Gharshub", fontSize: 18),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        ],
        backgroundColor: AppColors.whiteColor,
        elevation: 3,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                "DashBoard",
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontheight: 3,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                        _reusableExpanedWidget("Total Assigned", "50"),
                        SizedBox(width: 5),
                        _reusableExpanedWidget("Present", "5"),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        _reusableExpanedWidget("Absent", "50"),
                        SizedBox(width: 5),
                        _reusableExpanedWidget("StandBy", "5"),
                      ],
                    ),
                    SizedBox(height: 7),
                    CustomButton(
                      onTap: () {
                        Get.to(MakeAttendancePage());
                      },
                      text: "Mark Attendance",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                    AppText("Total Project : 5", fontheight: 2),
                    SizedBox(height: 7),
                    _reusableListtile("Project Alpha", "On Track", 80),

                    SizedBox(height: 7),
                    _reusableListtile(
                      "Project Alpha",
                      "On Track",
                      80,
                      color: Colors.orange.shade300,
                    ),
                    SizedBox(height: 7),
                    CustomButton(
                      onTap: () {
                        Get.to(ProjectsPage());
                      },
                      text: "View Projects",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                      "Alert & Attetion",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontheight: 1,
                    ),
                    SizedBox(height: 7),
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColors.lightRedColor,
                      ),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: AppText(
                        "2 task delayed",
                        color: AppColors.redColor,
                      ),
                    ),
                    SizedBox(height: 7),
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColors.lightRedColor,
                      ),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 10),
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

  Expanded _reusableExpanedWidget(title, value) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.skyColor,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            AppText(title ?? "", fontWeight: FontWeight.bold),
            AppText(value ?? "", fontWeight: FontWeight.normal, fontheight: 2),
          ],
        ),
      ),
    );
  }

  _reusableListtile(title, status, value, {color}) {
    return ListTile(
      minLeadingWidth: double.infinity,
      contentPadding: EdgeInsets.only(left: 0),
      leading: Column(
        children: [
          AppText(title ?? "", fontheight: 1, fontWeight: FontWeight.bold),
          SizedBox(height: 7),
          Container(
            width: 100,
            decoration: BoxDecoration(
              color: color ?? AppColors.lightGreenColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Center(child: AppText(status ?? "", fontSize: 10)),
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
