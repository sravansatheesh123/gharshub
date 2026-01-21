class LatestLeaveResponseModel {
  final LeaveModel? leave;

  LatestLeaveResponseModel({this.leave});

  factory LatestLeaveResponseModel.fromJson(Map<String, dynamic> json) {
    return LatestLeaveResponseModel(
      leave: json["leave"] != null ? LeaveModel.fromJson(json["leave"]) : null,
    );
  }
}

class LeaveModel {
  final String? id;
  final String? status;
  final String? updatedAt;

  LeaveModel({
    this.id,
    this.status,
    this.updatedAt,
  });

  factory LeaveModel.fromJson(Map<String, dynamic> json) {
    return LeaveModel(
      id: json["_id"],
      status: json["status"],
      updatedAt: json["updatedAt"],
    );
  }
}
