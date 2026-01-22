import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:flutter/material.dart';

class PayslipController extends GetxController {
  late SignatureController signatureController;

  Rx<Uint8List?> signatureImage = Rx<Uint8List?>(null);

  @override
  void onInit() {
    super.onInit();
    signatureController = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
    );
  }

  void clearSignature() {
    signatureController.clear();
    signatureImage.value = null;
  }

  Future<void> saveSignature() async {
    if (signatureController.isNotEmpty) {
      final image = await signatureController.toPngBytes();
      signatureImage.value = image;
    }
  }

  @override
  void onClose() {
    signatureController.dispose();
    super.onClose();
  }
}
