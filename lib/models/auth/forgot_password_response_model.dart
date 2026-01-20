class ForgotPasswordResponseModel {
  final bool success;
  final String message;

  ForgotPasswordResponseModel({
    required this.success,
    required this.message,
  });

  factory ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponseModel(
      success: json["success"] ?? true,
      message: json["message"] ?? "Reset link sent successfully",
    );
  }
}
