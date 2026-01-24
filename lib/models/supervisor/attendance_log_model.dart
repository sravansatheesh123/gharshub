class AttendanceLogModel {
  final String id;
  final String date;
  final AttendanceUser user;
  final String? inTime;
  final String? outTime;
  final String? status;

  final String? displayInTime;
  final String? displayOutTime;

  AttendanceLogModel({
    required this.id,
    required this.date,
    required this.user,
    this.inTime,
    this.outTime,
    this.status,
    this.displayInTime,
    this.displayOutTime,
  });

  factory AttendanceLogModel.fromJson(Map<String, dynamic> json) {
    return AttendanceLogModel(
      id: json["_id"] ?? "",
      date: json["date"] ?? "",
      user: AttendanceUser.fromJson(json["user"] ?? {}),
      inTime: json["inTime"],
      outTime: json["outTime"],
      status: json["status"],
      displayInTime: json["displayInTime"],
      displayOutTime: json["displayOutTime"],
    );
  }
}

class AttendanceUser {
  final String id;
  final String name;
  final String employeeId;

  AttendanceUser({
    required this.id,
    required this.name,
    required this.employeeId,
  });

  factory AttendanceUser.fromJson(Map<String, dynamic> json) {
    return AttendanceUser(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      employeeId: json["employee_id"] ?? "",
    );
  }
}
