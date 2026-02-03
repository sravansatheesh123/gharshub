import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gharshub/controller/project/project_controller.dart';
import 'package:gharshub/controller/supervisor/project_controller.dart';
import 'package:gharshub/core/app_colors.dart';
import 'package:gharshub/custom_widgets/app_button.dart';
import 'package:gharshub/custom_widgets/app_text.dart';
import 'package:gharshub/screen/Supervisor/view_task/view_task_page.dart';
import 'package:intl/intl.dart';

class SPV_ProjectsPage extends StatelessWidget {
  const SPV_ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SPV_ProjectController>(
      init: SPV_ProjectController(),
      // id: "SPV_ProjectsPage",
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.whiteColor,
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

        body: controller.isLoading
            ? Center(child: AppText("Loading"))
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText("Project DETAILS".toUpperCase()),
                          ListTile(
                            leading: AppText("Total Assignments"),
                            trailing: AppText(
                              controller
                                      .spvProjectModel
                                      ?.data
                                      ?.stats
                                      ?.totalAssignments
                                      .toString() ??
                                  "",
                            ),
                          ),

                          ListTile(
                            minTileHeight: 20,
                            leading: AppText("Overall Progress"),
                            trailing: AppText(
                              "${controller.spvProjectModel?.data?.stats?.overallProgress.toString() ?? ""} %",
                            ),
                          ),
                          ListTile(
                            leading: AppText("Team members"),
                            trailing: AppText(
                              controller
                                      .spvProjectModel
                                      ?.data
                                      ?.stats
                                      ?.totalAssignedPeople
                                      .toString() ??
                                  "",
                            ),
                          ),
                          ListTile(
                            minTileHeight: 20,
                            leading: AppText("Active Task"),
                            trailing: AppText(
                              controller
                                      .spvProjectModel
                                      ?.data
                                      ?.stats
                                      ?.activeAssignments
                                      .toString() ??
                                  "",
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10),
                      controller.spvProjectModel?.data?.assignments?.length == 0
                          ? Container()
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller
                                  .spvProjectModel
                                  ?.data
                                  ?.assignments
                                  ?.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 20,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.blackColor
                                                .withOpacity(0.08),
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
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  AppText(
                                                    controller
                                                            .spvProjectModel
                                                            ?.data
                                                            ?.assignments?[index]
                                                            .title ??
                                                        "",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                  AppText(
                                                    "code : ${controller.spvProjectModel?.data?.assignments?[index].code ?? ""}",
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontheight: 2,
                                                    fontSize: 12,
                                                  ),
                                                  AppText(
                                                    "Client : ${controller.spvProjectModel?.data?.assignments?[index].clientName ?? ""}",
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontheight: 1,
                                                    fontSize: 12,
                                                  ),
                                                ],
                                              ),
                                              Spacer(),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 10,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                    color: AppColors
                                                        .lightGreenColor,
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 5,
                                                      backgroundColor: AppColors
                                                          .lightGreenColor,
                                                    ),
                                                    SizedBox(width: 5),
                                                    AppText(
                                                      controller
                                                              .spvProjectModel
                                                              ?.data
                                                              ?.assignments?[index]
                                                              .statusLabel ??
                                                          "",
                                                      color:
                                                          AppColors.greenColor,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              AppText(
                                                "Overall Performance",
                                                color: AppColors.buttonColor,
                                              ),
                                              AppText(
                                                "Assigned :${controller.spvProjectModel?.data?.assignments?[index].assigned ?? ""}",
                                                color: AppColors.buttonColor,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          LinearProgressIndicator(
                                            value: 60 / 100,
                                            color: AppColors.buttonColor,
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              _reusableContainer(
                                                icon: Icons.check_circle,
                                                textColor: AppColors.greenColor,
                                                boxColor:
                                                    AppColors.lightGreenColor,
                                                status: "Completed",
                                                count:
                                                    controller
                                                        .spvProjectModel
                                                        ?.data
                                                        ?.assignments?[index]
                                                        .completed
                                                        .toString() ??
                                                    "",
                                              ),
                                              SizedBox(width: 3),
                                              _reusableContainer(
                                                icon: Icons.error_rounded,
                                                textColor: AppColors.redColor,
                                                boxColor:
                                                    AppColors.lightRedColor,
                                                status: "Overdue",
                                                count:
                                                    controller
                                                        .spvProjectModel
                                                        ?.data
                                                        ?.assignments?[index]
                                                        .overdue
                                                        .toString() ??
                                                    "",
                                              ),
                                              SizedBox(width: 3),
                                              _reusableContainer(
                                                icon: Icons.timer,
                                                textColor: Colors.orange,
                                                boxColor:
                                                    AppColors.lightAmberColor,
                                                status: "Pending",
                                                count:
                                                    controller
                                                        .spvProjectModel
                                                        ?.data
                                                        ?.assignments?[index]
                                                        .pending
                                                        .toString() ??
                                                    "",
                                              ),
                                            ],
                                          ),

                                          ListTile(
                                            leading: AppText("Start Date"),
                                            trailing: AppText(
                                              formatAppDate(
                                                controller
                                                        .spvProjectModel
                                                        ?.data
                                                        ?.assignments?[index]
                                                        .startDate ??
                                                    "",
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            minTileHeight: 20,
                                            leading: AppText("End Date"),
                                            trailing: AppText(
                                              formatAppDate(
                                                controller
                                                        .spvProjectModel
                                                        ?.data
                                                        ?.assignments?[index]
                                                        .endDate ??
                                                    "",
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              CustomButton(
                                                width: 100,
                                                onTap: () {
                                                  Get.to(
                                                    ViewTaskPage(
                                                      projectId: controller
                                                          .spvProjectModel
                                                          ?.data
                                                          ?.assignments?[index]
                                                          .id,
                                                    ),
                                                  );
                                                },
                                                text: "View Task",
                                                textSize: 12,
                                              ),
                                              // Spacer(),
                                              // Container(
                                              //   width: 100,
                                              //   padding: EdgeInsets.symmetric(
                                              //     horizontal: 10,
                                              //     vertical: 10,
                                              //   ),
                                              //   decoration: BoxDecoration(
                                              //     borderRadius: BorderRadius.circular(10),
                                              //     border: Border.all(
                                              //       color: AppColors.buttonColor,
                                              //     ),
                                              //   ),
                                              //   child: Center(
                                              //     child: AppText(
                                              //       "View Team",
                                              //       color: AppColors.buttonColor,
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  _reusableContainer({icon, textColor, boxColor, status, count}) {
    return Expanded(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: boxColor,
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor),
            SizedBox(height: 6),
            AppText(status, color: textColor),
            SizedBox(height: 6),
            AppText(count, color: textColor),
          ],
        ),
      ),
    );
  }

  String formatAppDate(String? isoDate) {
    if (isoDate == null || isoDate.isEmpty) return "-";

    try {
      final date = DateTime.parse(isoDate);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return "-";
    }
  }
}
