import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gharshub/controller/supervisor/view_task_controller.dart';
import 'package:gharshub/core/app_colors.dart';
import 'package:gharshub/custom_widgets/app_bar.dart';
import 'package:gharshub/custom_widgets/app_button.dart';
import 'package:gharshub/custom_widgets/app_text.dart';
import 'package:intl/intl.dart';

class SubTaskPage extends StatefulWidget {
  const SubTaskPage({super.key, required this.projectId});
  final dynamic projectId;

  @override
  State<SubTaskPage> createState() => _SubTaskPageState();
}

class _SubTaskPageState extends State<SubTaskPage> {
  late SPV_ViewTaskController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.put(SPV_ViewTaskController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.viewSubTask(widget.projectId);
      controller.timeStamp(widget.projectId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.skyColor,
      appBar: AppBar(),
      body: GetBuilder<SPV_ViewTaskController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = controller.viewSubTaskModel?.data;

          if (data == null) {
            return const Center(child: Text("No data found"));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                /// MAIN TASK
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.task),
                    title: AppText(data.title ?? ""),
                    subtitle: AppText(data.projectName ?? ""),
                    trailing: AppText(data.status ?? ""),
                  ),
                ),

                const SizedBox(height: 10),

                /// SUB TASK LIST
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.subTasks?.length ?? 0,
                  itemBuilder: (_, index) {
                    final subTask = data.subTasks![index];

                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText(
                                        subTask.title ?? "",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: AppColors.buttonColor,
                                      ),
                                      AppText(
                                        formatAppDate(
                                          subTask.sourceStartTimestamp ?? "",
                                        ),
                                        fontheight: 2,
                                      ),
                                      subTask.remarks == ""
                                          ? Container()
                                          : Row(
                                              children: [
                                                AppText(
                                                  "Remarks",
                                                  fontheight: 2,
                                                ),
                                                SizedBox(width: 10),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 2,
                                                    vertical: 7,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          5,
                                                        ),
                                                    border: Border.all(
                                                      color: AppColors
                                                          .lightgrayColor,
                                                    ),
                                                  ),
                                                  child: AppText(
                                                    subTask.remarks ?? "",
                                                    fontSize: 9,
                                                    fontheight: 2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ],
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
                                      subTask.status ?? "",
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
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                          border: Border.all(
                                            color: AppColors.lightgrayColor,
                                          ),
                                        ),
                                        child: Center(
                                          child: AppText(
                                            subTask.totalQuantity.toString() ??
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
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                          border: Border.all(
                                            color: AppColors.lightgrayColor,
                                          ),
                                        ),
                                        child: Center(
                                          child: AppText(
                                            subTask.actualDurationMinutes
                                                    .toString() ??
                                                "",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    AppText("Covered Qty"),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 7,
                                          vertical: 7,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                          border: Border.all(
                                            color: AppColors.lightgrayColor,
                                          ),
                                        ),
                                        child: Center(
                                          child: AppText(
                                            subTask.coveredQuantity
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppText(
                                          subTask.distancePointA ?? "",
                                          fontSize: 10,
                                        ),
                                        GetBuilder<SPV_ViewTaskController>(
                                          builder: (controller) => CustomButton(
                                            onTap:
                                                controller
                                                        .spvSubTaskTimestambModel
                                                        ?.data
                                                        ?.actualStart ==
                                                    null
                                                ? () {
                                                    controller.startWork(
                                                      subTask.id.toString(),
                                                    );
                                                  }
                                                : () {},
                                            width: 70,
                                            height: 30,
                                            textSize: 10,
                                            color:
                                                controller
                                                        .spvSubTaskTimestambModel
                                                        ?.data
                                                        ?.actualStart ==
                                                    null
                                                ? AppColors.lightgrayColor
                                                : AppColors.buttonColor,
                                            text: "Start Work",
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    AppText("Destination - "),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppText(
                                          subTask.distancePointB ?? "",
                                          fontSize: 10,
                                        ),
                                        CustomButton(
                                          onTap:
                                              controller
                                                      .spvSubTaskTimestambModel
                                                      ?.data
                                                      ?.actualFinish ==
                                                  null
                                              ? () {
                                                  controller.finishWork(
                                                    subTask.id.toString(),
                                                  );
                                                }
                                              : () {},
                                          width: 70,
                                          height: 30,
                                          textSize: 10,
                                          text: "Finish Work",
                                          color:
                                              controller
                                                      .spvSubTaskTimestambModel
                                                      ?.data
                                                      ?.actualFinish ==
                                                  null
                                              ? AppColors.lightgrayColor
                                              : AppColors.buttonColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(),
                              ],
                            ),
                          ),

                          ListTile(
                            title: AppText(subTask.title ?? ""),
                            subtitle: AppText(
                              formatAppDate(subTask.sourceStartTimestamp),
                            ),
                            trailing: AppText(subTask.status ?? ""),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String formatAppDate(String? isoDate) {
    if (isoDate == null || isoDate.isEmpty) return "-";
    try {
      return DateFormat('MMM dd, yyyy').format(DateTime.parse(isoDate));
    } catch (_) {
      return "-";
    }
  }
}
