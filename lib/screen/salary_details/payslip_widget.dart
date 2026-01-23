import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gharshub/controller/dashboard/payslip/payslip_controller.dart';
import 'package:gharshub/core/app_colors.dart';
import 'package:gharshub/custom_widgets/app_text.dart';
import 'package:gharshub/screen/salary_details/digital_signature_widget.dart';

class PayslipWidget extends StatelessWidget {
  final String employeeId;
  final String year;
  final String? token;

  const PayslipWidget({
    super.key,
    required this.employeeId,
    required this.year,
    this.token,
  });

  @override
  Widget build(BuildContext context) {
    final PayslipController controller = Get.put(PayslipController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchSalaryDetails(
        employeeId: employeeId,
        year: year,
      );

    });

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        iconTheme: IconThemeData(color: AppColors.buttonColor),
        title: AppText(
          "Salary Slip",
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.buttonColor,
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lock_outline,
                    size: 55,
                    color: Colors.red.withOpacity(0.85),
                  ),
                  const SizedBox(height: 12),
                  AppText(
                    controller.errorMessage.value,
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: 160,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.fetchSalaryDetails(
                          employeeId: employeeId,
                          year: year,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Retry"),
                    ),
                  )
                ],
              ),
            ),
          );
        }



        final data = controller.payslipData.value;

        // If no data
        if (data == null) {
          return const Center(child: Text("No payslip data found"));
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _reusableContainer(
                  title: "Details of Pay",
                  childWidget: Column(
                    children: [
                      _reusableListtile("Basic Salary", data.basicSalary.toStringAsFixed(2)),
                      _reusableListtile("Per Day Salary", data.perDaySalary.toStringAsFixed(2)),
                      _reusableListtile("Per Hour", data.perHourSalary.toStringAsFixed(2)),
                      _reusableListtile("Normal OT Per Hour", data.normalOTPayment.toStringAsFixed(2)),
                      _reusableListtile("Holiday OT Per Hour", data.holidayOTPayment.toStringAsFixed(2)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                _reusableContainer(
                  title: "Salary Payable",
                  childWidget: Column(
                    children: [
                      _reusableListtile(
                        "Normal Hour",
                        data.basicSalary.toStringAsFixed(2),
                        isEnable: true,
                        subValue: "",
                      ),
                      _reusableListtile(
                        "Normal OT Hour",
                        data.normalOTTotal.toStringAsFixed(2),
                        isEnable: true,
                        subValue: "${data.normalOTHours.toStringAsFixed(0)} hrs",
                      ),
                      _reusableListtile(
                        "Holidays OT Per Hour",
                        data.holidayOTTotal.toStringAsFixed(2),
                        isEnable: true,
                        subValue: "${data.holidayOTHours.toStringAsFixed(0)} hrs",
                      ),
                      const Divider(),
                      _reusableListtile("Total", data.totalEarnings.toStringAsFixed(2)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                        const SizedBox(height: 20),
                        AppText(
                          "Total Net Pay",
                          color: AppColors.buttonColor,
                          fontSize: 20,
                        ),
                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 20),
                        AppText(
                          data.netPayable.toStringAsFixed(2),
                          color: AppColors.buttonColor,
                          fontSize: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _reusableContainer(
                  title: "Deductions",
                  childWidget: Column(
                    children: [
                      _reusableListtile("Advance Payment", data.advance.toStringAsFixed(2)),
                      _reusableListtile("Air Ticket", data.airTicket.toStringAsFixed(2)),
                      _reusableListtile("Absent", data.absentDaysAmount.toStringAsFixed(2)),
                      _reusableListtile("Half Day", data.halfDay.toStringAsFixed(2)),
                      _reusableListtile("Other Deductions", data.otherDeductionsTotal.toStringAsFixed(2)),
                      if (data.otherDeductionsRemarks.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: AppText(
                            data.otherDeductionsRemarks,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      const Divider(),
                      _reusableListtile("Total", data.totalDeductions.toStringAsFixed(2)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                _reusableContainer(
                  title: "Extra Payments",
                  childWidget: Column(
                    children: [
                      _reusableListtile("Allowance", data.allowance.toStringAsFixed(2)),
                      _reusableListtile("Other Payment", data.otherPaymentsTotal.toStringAsFixed(2)),
                      if (data.otherPaymentsRemarks.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: AppText(
                            data.otherPaymentsRemarks,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      const Divider(),
                      _reusableListtile("Total", (data.allowance + data.otherPaymentsTotal).toStringAsFixed(2)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                _reusableContainer(
                  title: "Employee Signature",
                  childWidget: Column(children: [DigitalSignatureWidget()]),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  _reusableListtile(title, value, {bool? isEnable, subValue}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: ListTile(
        minTileHeight: 30,
        leading: AppText(title ?? ""),
        title: isEnable == true
            ? Padding(
          padding: const EdgeInsets.only(left: 28.0),
          child: AppText(subValue ?? ""),
        )
            : Container(),
        trailing: AppText(value ?? ""),
      ),
    );
  }

  _reusableContainer({title, childWidget}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
            title ?? "",
            fontSize: 16,
            color: AppColors.buttonColor,
            fontWeight: FontWeight.bold,
          ),
          const Padding(padding: EdgeInsets.all(8.0), child: Divider()),
          childWidget ?? Container(),
        ],
      ),
    );
  }
}
