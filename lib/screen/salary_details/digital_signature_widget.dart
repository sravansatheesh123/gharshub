import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gharshub/controller/dashboard/payslip/payslip_controller.dart';
import 'package:gharshub/custom_widgets/app_text.dart';
import 'package:signature/signature.dart';

class DigitalSignatureWidget extends StatelessWidget {
  final String employeeId;
  final int month;
  final int year;

  DigitalSignatureWidget({
    super.key,
    required this.employeeId,
    required this.month,
    required this.year,
  });

  final PayslipController controller = Get.find<PayslipController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          final isSigned =
              controller.payslipData.value?.signatureStatus == "signed";

          if (isSigned) {
            return Container(
              height: 150,
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.green),
              ),
              child: AppText(
                "Payslip already signed",
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            );
          }

          return Container(
            height: 150,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey),
            ),
            child: Signature(
              controller: controller.signatureController,
              backgroundColor: Colors.white,
            ),
          );
        }),

        const SizedBox(height: 10),
        Obx(() {
          final isSigned =
              controller.payslipData.value?.signatureStatus == "signed";

          if (isSigned) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AppText(
                  "This payslip is already signed",
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ],
            );
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: controller.clearSignature,
                child: AppText("Clear"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () {
                  controller.saveSignature(
                    employeeId: employeeId,
                    month: month,
                    year: year,
                  );
                },
                child: AppText("Save"),
              ),
            ],
          );
        }),

        const SizedBox(height: 20),
        Obx(() {
          if (controller.signatureImage.value == null) {
            return const SizedBox();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppText("Saved Signature"),
              const SizedBox(height: 8),
              Image.memory(
                controller.signatureImage.value!,
                height: 100,
              ),
            ],
          );
        }),
      ],
    );
  }
}
