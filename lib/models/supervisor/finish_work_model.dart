
class SpvFinishWorkModel {
    bool? success;
    String? message;
    Data? data;

    SpvFinishWorkModel({this.success, this.message, this.data});

    SpvFinishWorkModel.fromJson(Map<String, dynamic> json) {
        success = json["success"];
        message = json["message"];
        data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["success"] = success;
        _data["message"] = message;
        if(data != null) {
            _data["data"] = data?.toJson();
        }
        return _data;
    }
}

class Data {
    String? subInquiryId;
    String? taskName;
    String? destinationFinishTimestamp;
    int? actualDurationMinutes;
    String? finishedOnTime;
    String? completionTimeliness;
    String? status;
    int? progress;
    int? quantityExceededBy;
    int? parentInquiryProgress;

    Data({this.subInquiryId, this.taskName, this.destinationFinishTimestamp, this.actualDurationMinutes, this.finishedOnTime, this.completionTimeliness, this.status, this.progress, this.quantityExceededBy, this.parentInquiryProgress});

    Data.fromJson(Map<String, dynamic> json) {
        subInquiryId = json["sub_inquiry_id"];
        taskName = json["task_name"];
        destinationFinishTimestamp = json["destination_finish_timestamp"];
        actualDurationMinutes = json["actual_duration_minutes"];
        finishedOnTime = json["finished_on_time"];
        completionTimeliness = json["completion_timeliness"];
        status = json["status"];
        progress = json["progress"];
        quantityExceededBy = json["quantity_exceeded_by"];
        parentInquiryProgress = json["parent_inquiry_progress"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["sub_inquiry_id"] = subInquiryId;
        _data["task_name"] = taskName;
        _data["destination_finish_timestamp"] = destinationFinishTimestamp;
        _data["actual_duration_minutes"] = actualDurationMinutes;
        _data["finished_on_time"] = finishedOnTime;
        _data["completion_timeliness"] = completionTimeliness;
        _data["status"] = status;
        _data["progress"] = progress;
        _data["quantity_exceeded_by"] = quantityExceededBy;
        _data["parent_inquiry_progress"] = parentInquiryProgress;
        return _data;
    }
}