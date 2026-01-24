class AttendanceLogModel {
  final String id;
  final String date;
  final AttendanceUser user;
  final String? inTime;
  final String? outTime;
  final String? status;

  final String? displayInTime;
  final String? displayOutTime;

  final PendingEdit? pendingEdit;

  AttendanceLogModel({
    required this.id,
    required this.date,
    required this.user,
    this.inTime,
    this.outTime,
    this.status,
    this.displayInTime,
    this.displayOutTime,
    this.pendingEdit,
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
      pendingEdit: json["pendingEdit"] != null
          ? PendingEdit.fromJson(json["pendingEdit"])
          : null,
    );
  }
}

class PendingEdit {
  final String? editedInTime;
  final String? editedOutTime;
  final String? reason;

  PendingEdit({
    this.editedInTime,
    this.editedOutTime,
    this.reason,
  });

  factory PendingEdit.fromJson(Map<String, dynamic> json) {
    return PendingEdit(
      editedInTime: json["editedInTime"],
      editedOutTime: json["editedOutTime"],
      reason: json["reason"],
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
