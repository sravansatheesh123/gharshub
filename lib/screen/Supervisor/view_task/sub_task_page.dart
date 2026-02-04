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

  void _showQtyDialog(
      BuildContext context,
      String subId,
      int totalQty,
      ) {

    TextEditingController qtyController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Enter Covered Quantity"),

          content: TextField(
            controller: qtyController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Max $totalQty",
            ),
          ),

          actions: [

            TextButton(
              onPressed: () => Get.back(),
              child: Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {

                int value =
                    int.tryParse(qtyController.text) ?? 0;

                if (value > totalQty) {
                  Get.snackbar(
                    "Error",
                    "Cannot exceed total quantity",
                  );
                  return;
                }

                controller.updateCoveredQty(
                  subId,
                  value,
                  widget.projectId,
                );

                Get.back();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }


  @override
  void initState() {
    super.initState();

    controller = Get.put(SPV_ViewTaskController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.viewSubTask(widget.projectId);
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

                                      subTask.remarks == ""
                                          ? Container()
                                          : Row(
                                        children: [
                                          AppText("Remarks",
                                              fontheight: 2),
                                          SizedBox(width: 10),
                                          Container(
                                            padding:
                                            EdgeInsets.symmetric(
                                              horizontal: 2,
                                              vertical: 7,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(5),
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
                                  

                                SizedBox(height: 10),

                                // ===============================
                                // YOUR REQUIRED DESIGN SECTION
                                // ===============================

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

                                        CustomButton(
                                          onTap: subTask.status == "pending"
                                              ? () {
                                            controller.startWork(
                                              subTask.id.toString(),
                                              widget.projectId,
                                            );
                                          }
                                              : null,

                                          width: 70,
                                          height: 30,
                                          textSize: 10,
                                          text: "Start Work",

                                          color: subTask.status == "pending"
                                              ? AppColors.buttonColor
                                              : AppColors.lightgrayColor,
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
                                          subTask.status == "in-progress"
                                              ? () {
                                            controller.finishWork(
                                              subTask.id.toString(),
                                              widget.projectId,
                                            );
                                          }
                                              : null,

                                          width: 70,
                                          height: 30,
                                          textSize: 10,
                                          text: "Finish Work",

                                          color:
                                          subTask.status == "in-progress"
                                              ? AppColors.buttonColor
                                              : AppColors.lightgrayColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // ============= WEB LIKE PROGRESS UI ==============

                                SizedBox(height: 10),

                                Row(
                                  children: [

                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        AppText(
                                          "Total Qty",
                                          fontWeight: FontWeight.bold,
                                        ),

                                        AppText(
                                          "${subTask.totalQuantity ?? 0}",
                                        ),
                                      ],
                                    ),

                                    SizedBox(width: 20),

                                    GestureDetector(
                                      onTap: subTask.status == "completed"
                                          ? () {
                                        Get.snackbar(
                                          "Not Allowed",
                                          "Work already completed. Cannot update quantity.",
                                        );
                                      }
                                          : () {
                                        _showQtyDialog(
                                          context,
                                          subTask.id.toString(),
                                          subTask.totalQuantity ?? 0,
                                        );
                                      },

                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 8,
                                        ),

                                        decoration: BoxDecoration(

                                          color: subTask.status == "completed"
                                              ? AppColors.lightgrayColor.withOpacity(.3)
                                              : Colors.white,

                                          border: Border.all(color: AppColors.lightgrayColor),
                                          borderRadius: BorderRadius.circular(5),
                                        ),

                                        child: AppText(
                                          "${subTask.coveredQuantity ?? 0} / ${subTask.totalQuantity ?? 0}",
                                        ),
                                      ),
                                    ),


                                    SizedBox(width: 20),

                                    AppText(
                                      "Progress : ${subTask.progress ?? 0} %",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),

                                SizedBox(height: 10),


                                Divider(),
                              ],
                            ),
                          ),

                          ListTile(
                            title: AppText(subTask.title ?? ""),
                            subtitle: AppText(
                              formatAppDate(
                                  subTask.sourceStartTimestamp),
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
      return DateFormat('MMM dd, yyyy')
          .format(DateTime.parse(isoDate));
    } catch (_) {
      return "-";
    }
  }
}
