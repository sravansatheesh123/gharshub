class ResetPasswordResponseModel {
  final bool success;
  final String message;

  ResetPasswordResponseModel({
    required this.success,
    required this.message,
  });

  factory ResetPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponseModel(
      success: json["success"] ?? true,
      message: json["message"] ?? "Password reset successful",
    );
  }
}
