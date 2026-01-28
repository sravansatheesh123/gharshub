class RecentLeaveResponse {
  final List<RecentLeave> recentLeaves;
  final int total;

  RecentLeaveResponse({
    required this.recentLeaves,
    required this.total,
  });

  factory RecentLeaveResponse.fromJson(Map<String, dynamic> json) {
    return RecentLeaveResponse(
      recentLeaves: (json["recentLeaves"] as List? ?? [])
          .map((e) => RecentLeave.fromJson(e))
          .toList(),
      total: json["total"] ?? 0,
    );
  }
}

class RecentLeave {
  final String id;
  final String reason;
  final DateTime startDate;
  final DateTime endDate;
  final int numberOfDays;
  final String status;

  RecentLeave({
    required this.id,
    required this.reason,
    required this.startDate,
    required this.endDate,
    required this.numberOfDays,
    required this.status,
  });

  factory RecentLeave.fromJson(Map<String, dynamic> json) {
    return RecentLeave(
      id: json["_id"],
      reason: json["reason"] ?? "",
      startDate: DateTime.parse(json["startDate"]),
      endDate: DateTime.parse(json["endDate"]),
      numberOfDays: json["numberOfDays"] ?? 0,
      status: json["status"] ?? "",
    );
  }
}
