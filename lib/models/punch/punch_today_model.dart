class PunchTodayResponseModel {
  final PunchTodayModel? punch;

  PunchTodayResponseModel({this.punch});

  factory PunchTodayResponseModel.fromJson(Map<String, dynamic> json) {
    return PunchTodayResponseModel(
      punch: json["punch"] != null ? PunchTodayModel.fromJson(json["punch"]) : null,
    );
  }
}

class PunchTodayModel {
  final String? id;
  final String? user;
  final String? date;
  final String? inTime;
  final String? outTime;
  final int? durationMinutes;

  PunchTodayModel({
    this.id,
    this.user,
    this.date,
    this.inTime,
    this.outTime,
    this.durationMinutes,
  });

  factory PunchTodayModel.fromJson(Map<String, dynamic> json) {
    return PunchTodayModel(
      id: json["_id"],
      user: json["user"],
      date: json["date"],
      inTime: json["inTime"],
      outTime: json["outTime"],
      durationMinutes: json["durationMinutes"],
    );
  }
}
