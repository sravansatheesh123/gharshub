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

  //web///
  static String generateWebSigningToken(int month, int year) =>
      "$baseUrl/api/technician/generate-web-signing-token/$month/$year";

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

  ///tech////

  static const String getRecentReceipt =
      "$baseUrl/api/salary-receipts/my-recent-receipts";
  static const String submitRecentReceipt =
      "$baseUrl/api/receipt-requests/request";
  static const String myRequest = "$baseUrl/api/receipt-requests/my-requests";
  static const String accessableReceipt =
      "$baseUrl/api/receipt-requests/accessible-receipts";

  static String downloadRecentReceipt(String employeeId, int month, int year) =>
      "$baseUrl/api/salary-receipts/download-url/$employeeId/$month/$year";
  static String submitSignature(String employeeId, int month, int year) =>
      "$baseUrl/api/salary-receipts/signature/$employeeId/$month/$year";

  static const String profile = "$baseUrl/api/auth/profile";

  static const String recentLeaves = "$baseUrl/api/technician/recent-leaves";

  static const String currentLeave =
      "$baseUrl/api/technician/current-leave-status";

  static const String project = "$baseUrl/api/technician/projects";

  // ------------  Supervisor Api -------------

  static const String spv_dashborad = "$baseUrl/site-supervisor/dashboard";
  static const String spv_profile = "$baseUrl/api/auth/profile";
  static const String spv_project = "$baseUrl/api/site-supervisor/project";
  viewTask({projectId}) {
    return "$baseUrl/api/site-supervisor/tasks?projectId=$projectId&type=project&page=1&limit=20";
  }

  viewSubTask({projectId}) {
    return "$baseUrl/api/site-supervisor/tasks/$projectId";
  }

  static String startSubTask(String subInquiryId) =>
      "$baseUrl/api/timestamp/subinquiry/$subInquiryId/start";

  static String finishSubTask(String subInquiryId) =>
      "$baseUrl/api/timestamp/subinquiry/$subInquiryId/finish";


  static String startTask(String inquiryId) =>
      "$baseUrl/api/timestamp/inquiry/$inquiryId/start";

  static String finishTask(String inquiryId) =>
      "$baseUrl/api/timestamp/inquiry/$inquiryId/finish";
}
