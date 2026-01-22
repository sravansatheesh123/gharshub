import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:gharshub/controller/dashboard/payslip/payslip_controller.dart';
import 'package:gharshub/core/app_colors.dart';
import 'package:gharshub/custom_widgets/app_text.dart';
import 'package:gharshub/screen/salary_details/digital_signature_widget.dart';
import 'package:signature/signature.dart';

class PayslipWidget extends StatelessWidget {
  const PayslipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: const Text("Salary Slip"),
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _reusableContainer(
                title: "Details of Pay",
                childWidget: Column(
                  children: [
                    _reusableListtile("Basic Salary", "1200.00"),
                    _reusableListtile("Per Day Salary", "39.00"),
                    _reusableListtile("Per Hour", "4.93"),
                    _reusableListtile("Normal OT Per Hour", "19.10"),
                    _reusableListtile("Holiday OT Per Hour", "7.40"),
                  ],
                ),
              ),
              SizedBox(height: 10),
              _reusableContainer(
                title: "Salary Payable",
                childWidget: Column(
                  children: [
                    _reusableListtile(
                      "Normal Hour",
                      "1200.00",
                      isEnable: true,
                      subValue: "",
                    ),
                    _reusableListtile(
                      "Normal OT Hour",
                      "39.00",
                      isEnable: true,
                      subValue: "",
                    ),
                    _reusableListtile(
                      "Holidays OT Per Hour",
                      "4.93",
                      isEnable: true,
                      subValue: "",
                    ),
                    Divider(),
                    _reusableListtile("Total", "1300"),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                      SizedBox(height: 20),
                      AppText(
                        "Total Net Pay",
                        color: AppColors.buttonColor,
                        fontSize: 20,
                      ),
                      SizedBox(height: 20),
                      Divider(),
                      SizedBox(height: 20),
                      AppText(
                        "1886.71",
                        color: AppColors.buttonColor,
                        fontSize: 20,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              _reusableContainer(
                title: "Deductions",
                childWidget: Column(
                  children: [
                    _reusableListtile("Advance Payment", ""),
                    _reusableListtile("Air Ticket", ""),
                    _reusableListtile("Absent", "4.93"),
                    _reusableListtile("Other Payment", "19.10"),
                    _reusableListtile("Holiday Salary", ""),
                    Divider(),
                    _reusableListtile("Total", "49.45"),
                  ],
                ),
              ),
              SizedBox(height: 10),
              _reusableContainer(
                title: "Extra Payments",
                childWidget: Column(
                  children: [
                    _reusableListtile("Allowance", "550.00"),
                    _reusableListtile("Other Payment", ""),
                    Divider(),
                    _reusableListtile("Total", "500"),
                  ],
                ),
              ),
              SizedBox(height: 10),
              _reusableContainer(
                title: "Employee Signature",
                childWidget: Column(children: [DigitalSignatureWidget()]),
              ),
            ],
          ),
        ),
      ),
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
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
          Padding(padding: const EdgeInsets.all(8.0), child: Divider()),
          childWidget ?? Container(),
        ],
      ),
    );
  }
}
