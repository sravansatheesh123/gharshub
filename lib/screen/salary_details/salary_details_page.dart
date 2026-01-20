import 'package:flutter/material.dart';
import 'package:gharshub/core/app_colors.dart';
import 'package:gharshub/custom_widgets/app_button.dart';
import 'package:gharshub/custom_widgets/app_text.dart';

class SalaryDetailsPage extends StatelessWidget {
  const SalaryDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.lightgrayColor.withOpacity(.1),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText("Total Hours : 128 hrs"),
                      AppText("Days Worked : 7"),
                    ],
                  ),
                  SizedBox(height: 10),

                  AppText("Month : Aug 2025"),
                ],
              ),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 8,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText("18 Jan"),
                        AppText("TASK-101198", fontWeight: FontWeight.normal),
                        AppText("09:00 - 10:17", fontWeight: FontWeight.normal),
                        AppText("11 Hrs"),
                      ],
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.redColor.withOpacity(.1),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText("Hourly Rate : AED 25", fontheight: 2),
                  AppText("Total Hours : 128", fontheight: 2),
                  AppText("Eligible Salary : AED 3200", fontheight: 2),
                  Row(
                    children: [
                      AppText("Status :", fontheight: 2),
                      SizedBox(width: 5),
                      AppText("Credited", color: Colors.green),
                      Spacer(),
                      AppText("Credited Date : 13 August 2925", fontheight: 2),
                    ],
                  ),
                  AppText("Salary Acknowledgment required", fontheight: 2),
                  CustomButton(onTap: () {}, text: "View & Sign"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
