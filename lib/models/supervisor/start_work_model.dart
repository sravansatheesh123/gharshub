
class SpvStartWorkModel {
    bool? success;
    String? message;
    Data? data;

    SpvStartWorkModel({this.success, this.message, this.data});

    SpvStartWorkModel.fromJson(Map<String, dynamic> json) {
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
    String? sourceStartTimestamp;
    String? startedOnTime;
    String? status;

    Data({this.subInquiryId, this.taskName, this.sourceStartTimestamp, this.startedOnTime, this.status});

    Data.fromJson(Map<String, dynamic> json) {
        subInquiryId = json["sub_inquiry_id"];
        taskName = json["task_name"];
        sourceStartTimestamp = json["source_start_timestamp"];
        startedOnTime = json["started_on_time"];
        status = json["status"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["sub_inquiry_id"] = subInquiryId;
        _data["task_name"] = taskName;
        _data["source_start_timestamp"] = sourceStartTimestamp;
        _data["started_on_time"] = startedOnTime;
        _data["status"] = status;
        return _data;
    }
}