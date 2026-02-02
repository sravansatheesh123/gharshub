import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gharshub/controller/supervisor/view_task_controller.dart';
import 'package:gharshub/custom_widgets/app_button.dart';
import 'package:gharshub/custom_widgets/app_text.dart';
import 'package:gharshub/screen/Supervisor/view_task/sub_task_page.dart';
import 'package:intl/intl.dart';

import '../../../core/app_colors.dart';

class ViewTaskPage extends StatefulWidget {
  const ViewTaskPage({super.key, this.projectId});
  final projectId;

  @override
  State<ViewTaskPage> createState() => _ViewTaskPageState();
}

class _ViewTaskPageState extends State<ViewTaskPage> {
  final spv_ViewTaskController = Get.put(SPV_ViewTaskController());
  @override
  void initState() {
    spv_ViewTaskController.viewTask(widget.projectId);
    // TODO: implement initState
    super.initState();
  }

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
      body: spv_ViewTaskController.isLoading
          ? Center(child: AppText("Loading..."))
          : ListView.builder(
              itemCount:
                  spv_ViewTaskController.viewTaskModel?.data?.tasks?.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.whiteColor,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: AppText(
                          spv_ViewTaskController
                                  .viewTaskModel
                                  ?.data
                                  ?.tasks?[index]
                                  .displayInfo ??
                              "",
                        ),
                        subtitle: AppText("Due: 18 Aug"),
                        trailing: SizedBox(
                          width: 130,
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade500,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 1,
                                ),
                                child: Center(
                                  child: AppText(
                                    spv_ViewTaskController
                                            .viewTaskModel
                                            ?.data
                                            ?.tasks?[index]
                                            .statusLabel ??
                                        "",
                                    fontSize: 10,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: 6),
                              Icon(Icons.edit),
                            ],
                          ),
                        ),
                      ),
                      ListTile(
                        leading: AppText("Start Date"),
                        trailing: AppText(
                          formatAppDate(
                            spv_ViewTaskController
                                    .viewTaskModel
                                    ?.data
                                    ?.tasks?[index]
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
                            spv_ViewTaskController
                                    .viewTaskModel
                                    ?.data
                                    ?.tasks?[index]
                                    .endDate ??
                                "",
                          ),
                        ),
                      ),
                      ListTile(
                        leading: AppText("SubTask"),
                        trailing: AppText(
                          spv_ViewTaskController
                                  .viewTaskModel
                                  ?.data
                                  ?.tasks?[index]
                                  .subTasksCount
                                  .toString() ??
                              "",
                        ),
                      ),
                      CustomButton(
                        onTap: () {
                          Get.to(
                            SubTaskPage(
                              projectId: spv_ViewTaskController
                                  .viewTaskModel
                                  ?.data
                                  ?.tasks?[index]
                                  .id
                                  .toString(),
                            ),
                          );
                        },
                        text: "SubTask",
                      ),

                      Divider(),
                    ],
                  ),
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
