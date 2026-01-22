import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gharshub/controller/dashboard/payslip/payslip_controller.dart';
import 'package:gharshub/custom_widgets/app_text.dart';
import 'package:signature/signature.dart';

class DigitalSignatureWidget extends StatelessWidget {
  DigitalSignatureWidget({super.key});

  final PayslipController controller = Get.put(PayslipController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 150,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey)),
          child: Signature(
            controller: controller.signatureController,
            backgroundColor: Colors.white,
          
          ),
        ),

        const SizedBox(height: 10),

        /// -------- Buttons ----------
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: controller.clearSignature,
              child: AppText("Clear"),
            ),
            SizedBox(width: 10,),
            ElevatedButton(
              onPressed: controller.saveSignature,
              child: AppText("Save"),
            ),
          ],
        ),

        const SizedBox(height: 20),
        Obx(() {
          if (controller.signatureImage.value == null) {
            return const SizedBox();
          }
          return SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AppText("Saved Signature"),
                const SizedBox(height: 8),
                Image.memory(controller.signatureImage.value!, height: 100),
              ],
            ),
          );
        }),

        const SizedBox(height: 30),
      ],
    );
  }
}
