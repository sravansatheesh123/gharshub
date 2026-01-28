import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gharshub/controller/recent_receipt_controller.dart';
import 'package:gharshub/core/app_colors.dart';
import 'package:gharshub/custom_widgets/app_button.dart';
import 'package:gharshub/custom_widgets/app_text.dart';
import 'package:gharshub/custom_widgets/app_textfield.dart';
import 'package:intl/intl.dart';

class RecentReceiptWidget extends StatefulWidget {
  const RecentReceiptWidget({super.key});

  @override
  State<RecentReceiptWidget> createState() => _RecentReceiptWidgetState();
}

class _RecentReceiptWidgetState extends State<RecentReceiptWidget> {
  final recentReceiptController = Get.put(RecentReceiptController());
  @override
  void initState() {
    recentReceiptController.getRecentReceipt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecentReceiptController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.whiteColor),
          backgroundColor: AppColors.buttonColor,
          title: AppText(
            "Recent Salary Details",
            fontSize: 16,
            color: AppColors.whiteColor,
          ),
        ),
        body: controller.isLoading == true
            ? Center(child: CircularProgressIndicator())
            // ignore: prefer_is_empty
            : recentReceiptController
                      .receiptModel
                      ?.data
                      ?.recentReceipts
                      ?.length ==
                  0
            ? Container()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          CustomButton(
                            onTap: controller.isEnableRequest == true
                                //  submit  receipt --------------------------
                                ? () {}
                                //  request receipt --------------------------
                                : () {
                                    controller.setReceiptRequest(true);
                                  },
                            text: controller.isEnableRequest == true
                                ? "Submit Request"
                                : "+ Request Receipt",
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: controller.selectedMonth,
                                    hint: const Text('Select Month'),
                                    items: controller.months.map((month) {
                                      return DropdownMenuItem(
                                        value: month,
                                        child: Text(month),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      controller.selectedMonth = value;
                                      // print(
                                      //   'Selected Month: $controller.selectedMonth',
                                      // );
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'Month *',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: DropdownButtonFormField<int>(
                                    value: controller.selectedYear,
                                    items: List.generate(5, (index) {
                                      int year = DateTime.now().year - index;
                                      return DropdownMenuItem(
                                        value: year,
                                        child: Text(year.toString()),
                                      );
                                    }),
                                    onChanged: (value) {
                                      controller.selectedYear = value!;
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'Year *',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CustomTextField(
                            textEditingController: controller.reasonReceiptCtlr,
                            name: "Reason",
                            isThisFieldRequired: true,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.skyColor.withOpacity(.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              " Employee name: ${recentReceiptController.receiptModel?.data?.employee?.name ?? ""}",
                            ),
                            AppText(
                              " Employee role: ${recentReceiptController.receiptModel?.data?.employee?.role ?? ""}",
                              fontheight: 2,
                            ),
                            AppText(
                              " Employee department: ${recentReceiptController.receiptModel?.data?.employee?.department ?? ""}",
                              fontheight: 2,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ignore: prefer_is_empty
                    recentReceiptController
                                .receiptModel
                                ?.data
                                ?.recentReceipts
                                ?.length ==
                            0
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.blackColor.withOpacity(
                                      0.08,
                                    ),
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
                                    "RECIEPT DETAILS",
                                    color: AppColors.buttonColor,
                                  ),
                                  ListView.builder(
                                    itemCount: recentReceiptController
                                        .receiptModel
                                        ?.data
                                        ?.recentReceipts
                                        ?.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ListTile(
                                            contentPadding: EdgeInsets.only(
                                              left: 0,
                                            ),
                                            leading: Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 8.0,
                                              ),
                                              child: Icon(
                                                Icons.calendar_view_day_rounded,
                                                color: AppColors.buttonColor,
                                              ),
                                            ),
                                            subtitle: AppText(
                                              recentReceiptController
                                                  .receiptModel
                                                  ?.data
                                                  ?.recentReceipts?[index]
                                                  .receipt
                                                  ?.receiptNumber,
                                              fontSize: 10,
                                              color: AppColors.lightgrayColor,
                                            ),

                                            title: AppText(
                                              formatAppDate(
                                                recentReceiptController
                                                    .receiptModel
                                                    ?.data
                                                    ?.recentReceipts?[index]
                                                    .receipt
                                                    ?.signedAt,
                                              ),
                                              color: AppColors.buttonColor,
                                            ),
                                            trailing: SizedBox(
                                              width: 120,
                                              child: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      AppText(
                                                        "₹ ${recentReceiptController.receiptModel?.data?.recentReceipts?[index].summary?.netPayable.toString()}" ??
                                                            "",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            const Color.fromARGB(
                                                              255,
                                                              11,
                                                              133,
                                                              17,
                                                            ),
                                                      ),
                                                      AppText(
                                                        "Net payable",
                                                        fontSize: 10,
                                                        color: AppColors
                                                            .lightgrayColor,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(width: 10),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: AppColors
                                                          .lightGreenColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            7,
                                                          ),
                                                    ),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 2,
                                                          vertical: 2,
                                                        ),
                                                    child: AppText(
                                                      recentReceiptController
                                                              .receiptModel
                                                              ?.data
                                                              ?.recentReceipts?[index]
                                                              .receipt
                                                              ?.receiptStatus ??
                                                          "",
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          reusableTitleWidget(
                                            Icons.work,
                                            "Work Summary",
                                          ),
                                          ListTile(
                                            minTileHeight: 30,
                                            leading: AppText("Days :"),
                                            trailing: AppText(
                                              recentReceiptController
                                                      .receiptModel
                                                      ?.data
                                                      ?.recentReceipts?[index]
                                                      .summary
                                                      ?.daysWorked
                                                      .toString() ??
                                                  "",
                                            ),
                                          ),
                                          ListTile(
                                            minTileHeight: 30,
                                            leading: AppText("Hours :"),
                                            trailing: AppText(
                                              recentReceiptController
                                                      .receiptModel
                                                      ?.data
                                                      ?.recentReceipts?[index]
                                                      .summary
                                                      ?.totalWorkHours
                                                      .toString() ??
                                                  "",
                                            ),
                                          ),
                                          ListTile(
                                            minTileHeight: 30,
                                            leading: AppText("OT Hours :"),
                                            trailing: AppText(
                                              recentReceiptController
                                                      .receiptModel
                                                      ?.data
                                                      ?.recentReceipts?[index]
                                                      .summary
                                                      ?.totalHolidayOvertime
                                                      .toString() ??
                                                  "",
                                            ),
                                          ),
                                          reusableTitleWidget(
                                            Icons.payment,
                                            "Salary Details",
                                          ),
                                          ListTile(
                                            minTileHeight: 30,
                                            leading: AppText("Gross :"),
                                            trailing: AppText(
                                              recentReceiptController
                                                      .receiptModel
                                                      ?.data
                                                      ?.recentReceipts?[index]
                                                      .salaryDetails
                                                      ?.grossSalary
                                                      .toString() ??
                                                  "",
                                            ),
                                          ),
                                          ListTile(
                                            minTileHeight: 30,
                                            leading: AppText("Deductions :"),
                                            trailing: AppText(
                                              recentReceiptController
                                                      .receiptModel
                                                      ?.data
                                                      ?.recentReceipts?[index]
                                                      .salaryDetails
                                                      ?.totalDeductions
                                                      .toString() ??
                                                  "",
                                            ),
                                          ),
                                          Divider(),
                                          ListTile(
                                            minTileHeight: 30,
                                            leading: AppText("Net :"),
                                            trailing: AppText(
                                              recentReceiptController
                                                      .receiptModel
                                                      ?.data
                                                      ?.recentReceipts?[index]
                                                      .salaryDetails
                                                      ?.netPayable
                                                      .toString() ??
                                                  "",
                                            ),
                                          ),
                                          reusableTitleWidget(
                                            Icons.receipt,
                                            "Receipt Info ",
                                          ),
                                          ListTile(
                                            minTileHeight: 30,
                                            leading: AppText("Generated :"),
                                            trailing: AppText(
                                              formatAppDate(
                                                recentReceiptController
                                                        .receiptModel
                                                        ?.data
                                                        ?.recentReceipts?[index]
                                                        .receipt
                                                        ?.generatedAt
                                                        .toString() ??
                                                    "",
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            minTileHeight: 30,
                                            leading: AppText("Signed :"),
                                            trailing: AppText(
                                              formatAppDate(
                                                recentReceiptController
                                                        .receiptModel
                                                        ?.data
                                                        ?.recentReceipts?[index]
                                                        .receipt
                                                        ?.signedAt
                                                        .toString() ??
                                                    "",
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            minTileHeight: 30,
                                            leading: AppText("Status :"),
                                            trailing: AppText(
                                              recentReceiptController
                                                      .receiptModel
                                                      ?.data
                                                      ?.recentReceipts?[index]
                                                      .receipt
                                                      ?.signatureStatus
                                                      .toString() ??
                                                  "",
                                            ),
                                          ),
                                          // AppText(
                                          //   " Total Work hours :${recentReceiptController.receiptModel?.data?.recentReceipts?[index].summary?.totalWorkHours}",
                                          //   fontheight: 2,
                                          // ),
                                          // AppText(
                                          //   " Total salary :${recentReceiptController.receiptModel?.data?.recentReceipts?[index].summary?.basicSalary}",
                                          //   fontheight: 2,
                                          // ),
                                          // AppText(
                                          //   " Receipt status :${recentReceiptController.receiptModel?.data?.recentReceipts?[index].receipt?.receiptStatus}",
                                          // ),
                                          // AppText(
                                          //   " Signature status :${recentReceiptController.receiptModel?.data?.recentReceipts?[index].receipt?.signatureStatus}",
                                          //   fontheight: 2,
                                          // ),
                                          // AppText(
                                          //   " file :${recentReceiptController.receiptModel?.data?.recentReceipts?[index].receipt?.fileName}",
                                          //   fontheight: 2,
                                          // ),
                                        ],
                                      ),
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
    );
  }

  reusableTitleWidget(icon, title) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 0),
      leading: Icon(icon, color: AppColors.buttonColor),
      title: AppText(title ?? "", color: AppColors.buttonColor),
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
