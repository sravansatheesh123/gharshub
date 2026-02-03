import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gharshub/core/app_colors.dart';
import 'package:gharshub/custom_widgets/app_button.dart';
import 'package:gharshub/custom_widgets/app_text.dart';

import '../../../controller/supervisor/make_attendance_controller.dart';

class MakeAttendancePage extends StatelessWidget {
  const MakeAttendancePage({super.key});

  String _formatDate(DateTime date) {
    return "${date.year.toString().padLeft(4, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MakeAttendanceController());

    final w = MediaQuery.of(context).size.width;
    final bool isSmall = w < 380;

    return Scaffold(
      backgroundColor: AppColors.skyColor,
      appBar: AppBar(
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(radius: 40),
        ),
        title: AppText("Gharshub", fontSize: 18),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
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
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                child: isSmall
                    ? Column(
                  children: [
                    /// Select Date
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Select Date",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Obx(() {
                          return InkWell(
                            onTap: () async {
                              final now = DateTime.now();
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: now,
                                firstDate: DateTime(now.year - 2),
                                lastDate: DateTime(now.year + 2),
                              );

                              if (picked != null) {
                                controller.selectedDate.value =
                                    _formatDate(picked);
                              }
                            },
                            child: Container(
                              height: 40,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12),
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.black12),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    controller.selectedDate.value.isEmpty
                                        ? "Select Date"
                                        : controller.selectedDate.value,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const Icon(Icons.calendar_month,
                                      size: 18),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 38,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () async {
                                await controller.fetchAll(
                                  date: controller.selectedDate.value,
                                );
                              },
                              child: const Text(
                                "Apply",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Obx(() {
                            return Container(
                              height: 38,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "Total Records: ${controller.logs.length}",
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ],
                )
                    : Row(
                  children: [
                    const SizedBox(width: 12),

                    /// Select Date
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Select Date",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Obx(() {
                            return InkWell(
                              onTap: () async {
                                final now = DateTime.now();
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate: now,
                                  firstDate: DateTime(now.year - 2),
                                  lastDate: DateTime(now.year + 2),
                                );

                                if (picked != null) {
                                  controller.selectedDate.value =
                                      _formatDate(picked);
                                }
                              },
                              child: Container(
                                height: 40,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12),
                                decoration: BoxDecoration(
                                  border:
                                  Border.all(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller.selectedDate.value.isEmpty
                                          ? "Select Date"
                                          : controller.selectedDate.value,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const Icon(Icons.calendar_month,
                                        size: 18),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),


                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18),
                        child: SizedBox(
                          height: 38,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () async {
                              await controller.fetchAll(
                                date: controller.selectedDate.value,
                              );
                            },
                            child: const Text(
                              "Apply",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),


                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18),
                        child: Obx(() {
                          return Container(
                            height: 38,
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "Total Records: ${controller.logs.length}",
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),


              Container(
                width: double.infinity,
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (controller.error.value.isNotEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: AppText(
                          controller.error.value,
                          color: AppColors.redColor,
                        ),
                      ),
                    );
                  }

                  if (controller.technicians.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: AppText(
                          "No people found",
                          color: AppColors.lightgrayColor,
                        ),
                      ),
                    );
                  }

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText("All People", fontWeight: FontWeight.bold),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
                      ListView.builder(
                        itemCount: controller.technicians.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final tech = controller.technicians[index];
                          final log = controller.getLogForUser(tech.id);

                          final inTime = log?.inTime;
                          final outTime = log?.outTime;

                          final displayIn = (log?.displayInTime != null &&
                              log!.displayInTime!.toString().trim().isNotEmpty)
                              ? log.displayInTime!
                              : (log?.pendingEdit?.editedInTime != null &&
                              log!.pendingEdit!.editedInTime!.toString().trim().isNotEmpty)
                              ? log.pendingEdit!.editedInTime!
                              : (log?.inTime != null && log!.inTime!.toString().trim().isNotEmpty)
                              ? log.inTime!
                              : "--:--";

                          final displayOut = () {
                            if (log == null) return "--:--";

                            final inT = log.inTime?.trim() ?? "";
                            if (log.displayOutTime != null &&
                                log.displayOutTime!.trim().isNotEmpty &&
                                log.displayOutTime!.trim() != inT) {
                              return log.displayOutTime!;
                            }
                            if (log.pendingEdit?.editedOutTime != null &&
                                log.pendingEdit!.editedOutTime!.trim().isNotEmpty) {
                              return log.pendingEdit!.editedOutTime!;
                            }
                            if (log.outTime != null &&
                                log.outTime!.trim().isNotEmpty) {
                              return log.outTime!;
                            }

                            return "--:--";
                          }();

                          return ListTile(
                            minTileHeight: 30,
                            contentPadding: const EdgeInsets.only(left: 0),
                            leading: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Obx(() {
                                return Checkbox(
                                  value: controller.isSelected(tech.id),
                                  onChanged: (val) {
                                    controller.toggleSelection(
                                      tech.id,
                                      val ?? false,
                                    );
                                  },
                                );
                              }),
                            ),
                            title: AppText(
                              tech.name.isEmpty ? "Employee" : tech.name,
                            ),
                            subtitle: AppText(
                              "Emp ID - ${tech.employeeId}  |  ${tech.project}",
                              fontheight: 2,
                              fontWeight: FontWeight.normal,
                              color: AppColors.lightgrayColor,
                              fontSize: 10,
                            ),
                            trailing: SizedBox(
                              width: 90,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Text(
                                        "IN ",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      AppText(
                                        displayIn,
                                        fontSize: 10,
                                        color: AppColors.lightgrayColor,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Text(
                                        "OUT ",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      AppText(
                                        displayOut,
                                        fontSize: 10,
                                        color: AppColors.lightgrayColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }),
              ),

              const SizedBox(height: 10),


              Container(
                width: double.infinity,
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            height: 30,
                            textSize: 10,
                            onTap: () {
                              controller.showPunchInPopup(context);
                            },
                            text: "Punch In",
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: CustomButton(
                            height: 30,
                            textSize: 10,
                            onTap: () {
                              controller.showPunchOutPopup(context);
                            },
                            text: "Punch Out",
                            color: AppColors.lightAmberColor,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: CustomButton(
                            height: 30,
                            textSize: 10,
                            onTap: () {
                              print(
                                  "✅ Absent for: ${controller.selectedUserIds.toList()}");
                            },
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
