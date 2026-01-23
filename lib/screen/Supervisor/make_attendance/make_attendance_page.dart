import 'package:flutter/material.dart';
import 'package:gharshub/core/app_colors.dart';
import 'package:gharshub/custom_widgets/app_button.dart';
import 'package:gharshub/custom_widgets/app_text.dart';

class MakeAttendancePage extends StatelessWidget {
  const MakeAttendancePage({super.key});

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
                "People",
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText("All People", fontWeight: FontWeight.bold),
                        AppText("Assigned", fontWeight: FontWeight.bold),
                        AppText("StandBy", fontWeight: FontWeight.bold),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Divider(),
                    ),
                    ListView.builder(
                      itemCount: 8,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => ListTile(
                        minTileHeight: 30,
                        contentPadding: EdgeInsets.only(left: 0),
                        leading: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Checkbox(value: true, onChanged: (val) {}),
                        ),
                        title: AppText("Employee Name"),
                        subtitle: AppText(
                          "Role -  Project Name",
                          fontheight: 2,
                          fontWeight: FontWeight.normal,
                          color: AppColors.lightgrayColor,
                          fontSize: 10,
                        ),
                        trailing: SizedBox(
                          width: 70,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 5,
                                backgroundColor: AppColors.lightGreenColor,
                              ),
                              SizedBox(width: 5),
                              AppText(
                                "Working",
                                color: Colors.green,
                                fontSize: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
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
                      "Action for selected people",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontheight: 1,
                    ),
                    SizedBox(height: 7),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            height: 30,
                            textSize: 10,
                            onTap: () {},
                            text: "Punch In",
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(width: 5,),
                        Expanded(
                          child: CustomButton(
                            height: 30,
                            textSize: 10,
                            onTap: () {},
                            text: "Punch Out",
                            color: AppColors.lightAmberColor,
                          ),
                        ),
                         SizedBox(width: 5,),
                        Expanded(
                          child: CustomButton(
                            height: 30,
                            textSize: 10,
                            onTap: () {},
                            text: "Absent",
                            color: AppColors.redColor,
                          ),
                        ),
                      ],
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
}
