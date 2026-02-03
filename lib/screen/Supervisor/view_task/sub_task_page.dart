import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gharshub/controller/supervisor/view_task_controller.dart';
import 'package:gharshub/core/app_colors.dart';
import 'package:gharshub/custom_widgets/app_bar.dart';
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
    return GetBuilder<SPV_ViewTaskController>(
      init: SPV_ViewTaskController(),
      id: "",
      builder: (controller) =>
          Scaffold(
            backgroundColor: AppColors.skyColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: SuperVisorAppBar(),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
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
                            subtitle: AppText(
                              "Destination",
                              fontSize: 12,
                              color: AppColors.lightgrayColor,
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // AppText("Duration",fontSize: 12,),
                                AppText(
                                  spv_ViewTaskController
                                      .viewSubTaskModel
                                      ?.data
                                      ?.subTasks?[index]
                                      .status ??
                                      "",
                                  fontSize: 12,
                                  fontheight: 2,
                                ),
                                AppText(
                                  "Total  Qty: ${spv_ViewTaskController.viewSubTaskModel?.data?.subTasks?[index].totalQuantity}",
                                  fontSize: 12,
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            leading: AppText("Source"),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                AppText(
                                  spv_ViewTaskController
                                      .viewSubTaskModel
                                      ?.data
                                      ?.subTasks?[index]
                                      .distancePointA ??
                                      "",

                                ),

                                AppText(
                                  formatAppDate(
                                    spv_ViewTaskController
                                        .viewSubTaskModel
                                        ?.data
                                        ?.subTasks?[index]
                                        .sourceStartTimestamp ??
                                        "",
                                  ),
                                ),
                              ],
                            ),
                          ),


                          ListTile(
                            leading: AppText("Destination"),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                AppText(
                                  spv_ViewTaskController
                                      .viewSubTaskModel
                                      ?.data
                                      ?.subTasks?[index]
                                      .distancePointB ??
                                      "",

                                ),

                                AppText(
                                  formatAppDate(
                                    spv_ViewTaskController
                                        .viewSubTaskModel
                                        ?.data
                                        ?.subTasks?[index]
                                        .destinationFinishTimestamp ??
                                        "",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider()


                        ],
                      ),
                    ),
                  ),



                ],
              ),
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