class ApplyLeaveResponseModel {
  final String? message;
  final LeaveData? leave;

  ApplyLeaveResponseModel({
    this.message,
    this.leave,
  });

  factory ApplyLeaveResponseModel.fromJson(Map<String, dynamic> json) {
    return ApplyLeaveResponseModel(
      message: json["message"],
      leave: json["leave"] != null ? LeaveData.fromJson(json["leave"]) : null,
    );
  }
}

class LeaveData {
  final String? id;
  final String? user;
  final String? reason;
  final String? startDate;
  final String? endDate;
  final int? numberOfDays;
  final String? proofFilePath;
  final String? status;
  final String? appliedAt;
  final String? createdAt;
  final String? updatedAt;

  LeaveData({
    this.id,
    this.user,
    this.reason,
    this.startDate,
    this.endDate,
    this.numberOfDays,
    this.proofFilePath,
    this.status,
    this.appliedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory LeaveData.fromJson(Map<String, dynamic> json) {
    return LeaveData(
      id: json["_id"],
      user: json["user"],
      reason: json["reason"],
      startDate: json["startDate"],
      endDate: json["endDate"],
      numberOfDays: json["numberOfDays"],
      proofFilePath: json["proofFilePath"],
      status: json["status"],
      appliedAt: json["appliedAt"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
    );
  }
}
