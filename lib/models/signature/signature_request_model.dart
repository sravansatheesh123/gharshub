// models/signature_request_model.dart
class SignatureRequestModel {
  final String signatureType;
  final String signatureData;

  SignatureRequestModel({
    required this.signatureType,
    required this.signatureData,
  });

  Map<String, dynamic> toJson() {
    return {
      "signatureType": signatureType,
      "signatureData": signatureData,
    };
  }
}
