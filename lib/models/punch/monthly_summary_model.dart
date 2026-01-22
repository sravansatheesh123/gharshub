class MonthlySummaryResponse {
  final bool success;
  final MonthlySummary? summary;

  MonthlySummaryResponse({
    required this.success,
    this.summary,
  });

  factory MonthlySummaryResponse.fromJson(Map<String, dynamic> json) {
    return MonthlySummaryResponse(
      success: json["success"] == true,
      summary: json["summary"] == null
          ? null
          : MonthlySummary.fromJson(
        Map<String, dynamic>.from(json["summary"]),
      ),
    );
  }
}

class MonthlySummary {
  final double totalWorkHours;
  final double totalNormalOvertime;
  final double totalHolidayOvertime;

  MonthlySummary({
    required this.totalWorkHours,
    required this.totalNormalOvertime,
    required this.totalHolidayOvertime,
  });

  factory MonthlySummary.fromJson(Map<String, dynamic> json) {
    final map = Map<String, dynamic>.from(json);

    return MonthlySummary(
      totalWorkHours: (map["totalWorkHours"] ?? 0).toDouble(),
      totalNormalOvertime: (map["totalNormalOvertime"] ?? 0).toDouble(),
      totalHolidayOvertime: (map["totalHolidayOvertime"] ?? 0).toDouble(),
    );
  }
}
