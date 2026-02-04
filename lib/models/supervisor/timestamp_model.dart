
class SpvSubTaskTimestambModel {
    bool? success;
    Data? data;

    SpvSubTaskTimestambModel({this.success, this.data});

    SpvSubTaskTimestambModel.fromJson(Map<String, dynamic> json) {
        success = json["success"];
        data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["success"] = success;
        if(data != null) {
            _data["data"] = data?.toJson();
        }
        return _data;
    }
}

class Data {
    String? subInquiryId;
    String? taskName;
    String? parentInquiry;
    String? scheduledStart;
    String? scheduledFinish;
    String? actualStart;
    String? actualFinish;
    int? actualDurationMinutes;
    String? startedOnTime;
    String? finishedOnTime;
    String? completionTimeliness;
    String? currentStatus;
    int? currentProgress;
    QuantityInfo? quantityInfo;

    Data({this.subInquiryId, this.taskName, this.parentInquiry, this.scheduledStart, this.scheduledFinish, this.actualStart, this.actualFinish, this.actualDurationMinutes, this.startedOnTime, this.finishedOnTime, this.completionTimeliness, this.currentStatus, this.currentProgress, this.quantityInfo});

    Data.fromJson(Map<String, dynamic> json) {
        subInquiryId = json["sub_inquiry_id"];
        taskName = json["task_name"];
        parentInquiry = json["parent_inquiry"];
        scheduledStart = json["scheduled_start"];
        scheduledFinish = json["scheduled_finish"];
        actualStart = json["actual_start"];
        actualFinish = json["actual_finish"];
        actualDurationMinutes = json["actual_duration_minutes"];
        startedOnTime = json["started_on_time"];
        finishedOnTime = json["finished_on_time"];
        completionTimeliness = json["completion_timeliness"];
        currentStatus = json["current_status"];
        currentProgress = json["current_progress"];
        quantityInfo = json["quantity_info"] == null ? null : QuantityInfo.fromJson(json["quantity_info"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["sub_inquiry_id"] = subInquiryId;
        _data["task_name"] = taskName;
        _data["parent_inquiry"] = parentInquiry;
        _data["scheduled_start"] = scheduledStart;
        _data["scheduled_finish"] = scheduledFinish;
        _data["actual_start"] = actualStart;
        _data["actual_finish"] = actualFinish;
        _data["actual_duration_minutes"] = actualDurationMinutes;
        _data["started_on_time"] = startedOnTime;
        _data["finished_on_time"] = finishedOnTime;
        _data["completion_timeliness"] = completionTimeliness;
        _data["current_status"] = currentStatus;
        _data["current_progress"] = currentProgress;
        if(quantityInfo != null) {
            _data["quantity_info"] = quantityInfo?.toJson();
        }
        return _data;
    }
}

class QuantityInfo {
    int? total;
    int? covered;
    int? exceededBy;
    int? remaining;

    QuantityInfo({this.total, this.covered, this.exceededBy, this.remaining});

    QuantityInfo.fromJson(Map<String, dynamic> json) {
        total = json["total"];
        covered = json["covered"];
        exceededBy = json["exceeded_by"];
        remaining = json["remaining"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["total"] = total;
        _data["covered"] = covered;
        _data["exceeded_by"] = exceededBy;
        _data["remaining"] = remaining;
        return _data;
    }
}