class PunchToggleResponseModel {
  final String? status;
  final PunchModel? punch;
  final String? message;

  PunchToggleResponseModel({
    this.status,
    this.punch,
    this.message,
  });

  factory PunchToggleResponseModel.fromJson(Map<String, dynamic> json) {
    return PunchToggleResponseModel(
      status: json['status'],
      punch: json['punch'] != null ? PunchModel.fromJson(json['punch']) : null,
      message: json['message'],
    );
  }
}

class PunchModel {
  final String? id;
  final String? user;
  final String? date;
  final String? inTime;
  final String? outTime;
  final int? durationMinutes;

  PunchModel({
    this.id,
    this.user,
    this.date,
    this.inTime,
    this.outTime,
    this.durationMinutes,
  });

  factory PunchModel.fromJson(Map<String, dynamic> json) {
    return PunchModel(
      id: json['_id'],
      user: json['user'],
      date: json['date'],
      inTime: json['inTime'],
      outTime: json['outTime'],
      durationMinutes: json['durationMinutes'],
    );
  }
}
