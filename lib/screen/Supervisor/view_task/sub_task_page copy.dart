import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gharshub/controller/supervisor/view_task_controller.dart';
import 'package:gharshub/core/app_colors.dart';
import 'package:gharshub/custom_widgets/app_bar.dart';
import 'package:gharshub/custom_widgets/app_button.dart';
import 'package:gharshub/custom_widgets/app_text.dart';
import 'package:intl/intl.dart';

class SubTaskPage extends StatefulWidget {
  const SubTaskPage({super.key, this.projectId});
  final projectId;

  @override
  State<SubTaskPage> createState() => _SubTaskPageState();
}

class _SubTaskPageState extends State<SubTaskPage> {
  final spv_ViewTaskController = Get.put(SPV_ViewTaskController());
  @override
  void initState() {
    super.initState();
    spv_ViewTaskController.viewSubTask(widget.projectId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.skyColor,
      appBar: AppBar(),
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(50),
      //   child: SuperVisorAppBar(),
      // ),
      body: GetBuilder<SPV_ViewTaskController>(
        builder: (controller) {
          if (controller.isLoading) {
            return Center(child: AppText("Loading..."));
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.whiteColor,
                    ),
                    child: ListTile(
                      leading: Icon(Icons.task),
                      title: AppText(
                        spv_ViewTaskController.viewSubTaskModel?.data?.title ??
                            "",
                      ),
                      subtitle: AppText(
                        spv_ViewTaskController
                                .viewSubTaskModel
                                ?.data
                                ?.projectName ??
                            "",
                      ),
                      trailing: AppText(
                        spv_ViewTaskController.viewSubTaskModel?.data?.status ??
                            "",
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: spv_ViewTaskController
                        .viewSubTaskModel
                        ?.data
                        ?.subTasks
                        ?.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            leading: AppText(
                              spv_ViewTaskController
                                      .viewSubTaskModel
                                      ?.data
                                      ?.subTasks?[index]
                                      .title ??
                                  "",
                            ),
                            title: AppText(
                              formatAppDate(
                                spv_ViewTaskController
                                        .viewSubTaskModel
                                        ?.data
                                        ?.subTasks?[index]
                                        .sourceStartTimestamp ??
                                    "",
                              ),
                            ),
                            trailing: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.lightAmberColor,
                                border: Border.all(
                                  color: AppColors.lightAmberColor,
                                ),
                              ),
                              child: AppText(
                                spv_ViewTaskController
                                        .viewSubTaskModel
                                        ?.data
                                        ?.subTasks?[index]
                                        .status ??
                                    "",
                                fontSize: 12,
                                fontheight: 2,
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppText("Total Qty"),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 7,
                                    vertical: 7,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: AppColors.lightgrayColor,
                                    ),
                                  ),
                                  child: Center(
                                    child: AppText(
                                      spv_ViewTaskController
                                              .viewSubTaskModel
                                              ?.data
                                              ?.subTasks?[index]
                                              .totalQuantity
                                              .toString() ??
                                          "",
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              AppText("Duration"),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 7,
                                    vertical: 7,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: AppColors.lightgrayColor,
                                    ),
                                  ),
                                  child: Center(
                                    child: AppText(
                                      spv_ViewTaskController
                                              .viewSubTaskModel
                                              ?.data
                                              ?.subTasks?[index]
                                              .actualDurationMinutes
                                              .toString() ??
                                          "",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText("Source - "),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    spv_ViewTaskController
                                            .viewSubTaskModel
                                            ?.data
                                            ?.subTasks?[index]
                                            .distancePointA ??
                                        "",
                                    fontSize: 10,
                                  ),
                                  CustomButton(
                                    onTap: () {},
                                    width: 70,
                                    height: 30,
                                    textSize: 10,
                                    text: "Start Work",
                                  ),
                                ],
                              ),
                              Spacer(),
                              AppText("Destination - "),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    spv_ViewTaskController
                                            .viewSubTaskModel
                                            ?.data
                                            ?.subTasks?[index]
                                            .distancePointB ??
                                        "",
                                    fontSize: 10,
                                  ),
                                  CustomButton(
                                    onTap: () {},
                                    width: 70,
                                    height: 30,
                                    textSize: 10,
                                    text: "Finish Work",
                                    color: AppColors.lightgrayColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                 
                 
                  ),
                ],
              ),
            ),
          );
      
      
       
       
        },
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
