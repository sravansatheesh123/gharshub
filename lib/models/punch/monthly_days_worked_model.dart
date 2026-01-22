class MonthlyDaysWorkedResponse {
  final bool success;
  final MonthlyDaysWorkedData? data;

  MonthlyDaysWorkedResponse({required this.success, this.data});

  factory MonthlyDaysWorkedResponse.fromJson(Map<String, dynamic> json) {
    return MonthlyDaysWorkedResponse(
      success: json["success"] ?? false,
      data: json["data"] != null ? MonthlyDaysWorkedData.fromJson(json["data"]) : null,
    );
  }
}

class MonthlyDaysWorkedData {
  final int daysWorked;
  final int month;
  final int year;
  final int tillDate;

  MonthlyDaysWorkedData({
    required this.daysWorked,
    required this.month,
    required this.year,
    required this.tillDate,
  });

  factory MonthlyDaysWorkedData.fromJson(Map<String, dynamic> json) {
    return MonthlyDaysWorkedData(
      daysWorked: json["daysWorked"] ?? 0,
      month: json["month"] ?? 0,
      year: json["year"] ?? 0,
      tillDate: json["tillDate"] ?? 0,
    );
  }
}
