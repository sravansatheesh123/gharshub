
class CurrentLeaveModel {
    dynamic currentLeave;
    bool? isOnLeaveToday;
    String? status;

    CurrentLeaveModel({this.currentLeave, this.isOnLeaveToday, this.status});

    CurrentLeaveModel.fromJson(Map<String, dynamic> json) {
        currentLeave = json["currentLeave"];
        isOnLeaveToday = json["isOnLeaveToday"];
        status = json["status"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["currentLeave"] = currentLeave;
        _data["isOnLeaveToday"] = isOnLeaveToday;
        _data["status"] = status;
        return _data;
    }
}