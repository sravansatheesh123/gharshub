class ApiConstants {
  static const String baseUrl = "https://api.gharshub.com";

  static const String login = "$baseUrl/api/auth/login";
  static const String forgotPassword = "$baseUrl/api/auth/forgot-password";
  static const String resetPassword = "$baseUrl/api/auth/reset-password";
  static const String punchToggle = "$baseUrl/api/punch/toggle";
  static const String punchToday = "$baseUrl/api/punch/today";
  static const String latestLeave = "$baseUrl/api/leaves/latest";
  static const String applyLeave = "$baseUrl/api/leaves/apply";
  static const String monthlyDaysWorked =
      "$baseUrl/api/punch/monthly-days-worked";
  static const String monthlySummary = "$baseUrl/api/punch/monthly-summary";
  static String salaryDetails(String employeeId, String year) =>
      "$baseUrl/api/hr/salary-details/$employeeId/$year";
  static const String monthlyTimesheet = "$baseUrl/api/punch/monthly-timesheet";

  ////supervisor////
  static const String supervisorDashboardSummary =
      "$baseUrl/api/site-supervisor/dashboard/summary";
  static String supervisorAttendanceLogs(String date) =>
      "$baseUrl/api/site-supervisor/attendance/attendance-logs?date=$date";
  static const String supervisorAttendanceTechnicians =
      "$baseUrl/api/site-supervisor/attendance/technicians";
  static const String bulkManualPunch =
      "$baseUrl/api/punch/hr/bulk-manual-punch";
  static const String editPunch =
      "$baseUrl/api/site-supervisor/attendance/edit-punch";

  static const String getRecentReceipt =
      "$baseUrl/api/salary-receipts/my-recent-receipts";
        static const String submitRecentReceipt =
      "$baseUrl/api/receipt-requests/request";
}
