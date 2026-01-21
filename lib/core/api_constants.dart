class ApiConstants {
  static const String baseUrl = "https://api.gharshub.com";

  static const String login = "$baseUrl/api/auth/login";
  static const String forgotPassword = "$baseUrl/api/auth/forgot-password";
  static const String resetPassword = "$baseUrl/api/auth/reset-password";
  static const String punchToggle = "$baseUrl/api/punch/toggle";
  static const String punchToday = "$baseUrl/api/punch/today";
  static const String latestLeave = "$baseUrl/api/leaves/latest";
  static const String applyLeave = "$baseUrl/api/leaves/apply";
}
