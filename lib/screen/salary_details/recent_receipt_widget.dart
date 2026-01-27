import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gharshub/controller/recent_receipt_controller.dart';
import 'package:gharshub/core/app_colors.dart';
import 'package:gharshub/custom_widgets/app_text.dart';

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
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        backgroundColor: AppColors.buttonColor,
        title: AppText(
          "Recent Salary Details",
          fontSize: 16,
          color: AppColors.whiteColor,
        ),
      ),
      body:
          recentReceiptController.receiptModel?.data?.recentReceipts?.length ==
              0
          ? Container()
          : SingleChildScrollView(
              child: Column(
                children: [
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
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppText(
                                            " Total Work hours :${recentReceiptController.receiptModel?.data?.recentReceipts?[index].summary?.totalWorkHours}",
                                            fontheight: 2,
                                          ),
                                          AppText(
                                            " Total salary :${recentReceiptController.receiptModel?.data?.recentReceipts?[index].summary?.basicSalary}",
                                            fontheight: 2,
                                          ),
                                          AppText(
                                            " Receipt status :${recentReceiptController.receiptModel?.data?.recentReceipts?[index].receipt?.receiptStatus}",
                                          ),
                                          AppText(
                                            " Signature status :${recentReceiptController.receiptModel?.data?.recentReceipts?[index].receipt?.signatureStatus}",
                                            fontheight: 2,
                                          ),
                                          AppText(
                                            " file :${recentReceiptController.receiptModel?.data?.recentReceipts?[index].receipt?.fileName}",
                                            fontheight: 2,
                                          ),
                                        ],
                                      ),
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
    );
  }
}
