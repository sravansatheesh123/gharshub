
class MyRequestModel {
    bool? success;
    Data? data;

    MyRequestModel({this.success, this.data});

    MyRequestModel.fromJson(Map<String, dynamic> json) {
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
    List<Requests>? requests;

    Data({this.requests});

    Data.fromJson(Map<String, dynamic> json) {
        requests = json["requests"] == null ? null : (json["requests"] as List).map((e) => Requests.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(requests != null) {
            _data["requests"] = requests?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class Requests {
    String? id;
    String? employee;
    int? month;
    int? year;
    String? reason;
    String? status;
    bool? isTemporaryAccessActive;
    String? createdAt;
    String? updatedAt;
    int? v;
    String? accessExpiresAt;
    String? approvedAt;
    ApprovedBy? approvedBy;
    String? receiptId;
    String? remarks;
    String? monthName;
    bool? hasActiveAccess;
    TimeRemaining? timeRemaining;

    Requests({this.id, this.employee, this.month, this.year, this.reason, this.status, this.isTemporaryAccessActive, this.createdAt, this.updatedAt, this.v, this.accessExpiresAt, this.approvedAt, this.approvedBy, this.receiptId, this.remarks, this.monthName, this.hasActiveAccess, this.timeRemaining});

    Requests.fromJson(Map<String, dynamic> json) {
        id = json["_id"];
        employee = json["employee"];
        month = json["month"];
        year = json["year"];
        reason = json["reason"];
        status = json["status"];
        isTemporaryAccessActive = json["isTemporaryAccessActive"];
        createdAt = json["createdAt"];
        updatedAt = json["updatedAt"];
        v = json["__v"];
        accessExpiresAt = json["accessExpiresAt"];
        approvedAt = json["approvedAt"];
        approvedBy = json["approvedBy"] == null ? null : ApprovedBy.fromJson(json["approvedBy"]);
        receiptId = json["receiptId"];
        remarks = json["remarks"];
        monthName = json["monthName"];
        hasActiveAccess = json["hasActiveAccess"];
        timeRemaining = json["timeRemaining"] == null ? null : TimeRemaining.fromJson(json["timeRemaining"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["_id"] = id;
        _data["employee"] = employee;
        _data["month"] = month;
        _data["year"] = year;
        _data["reason"] = reason;
        _data["status"] = status;
        _data["isTemporaryAccessActive"] = isTemporaryAccessActive;
        _data["createdAt"] = createdAt;
        _data["updatedAt"] = updatedAt;
        _data["__v"] = v;
        _data["accessExpiresAt"] = accessExpiresAt;
        _data["approvedAt"] = approvedAt;
        if(approvedBy != null) {
            _data["approvedBy"] = approvedBy?.toJson();
        }
        _data["receiptId"] = receiptId;
        _data["remarks"] = remarks;
        _data["monthName"] = monthName;
        _data["hasActiveAccess"] = hasActiveAccess;
        if(timeRemaining != null) {
            _data["timeRemaining"] = timeRemaining?.toJson();
        }
        return _data;
    }
}

class TimeRemaining {
    int? hours;
    int? minutes;

    TimeRemaining({this.hours, this.minutes});

    TimeRemaining.fromJson(Map<String, dynamic> json) {
        hours = json["hours"];
        minutes = json["minutes"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["hours"] = hours;
        _data["minutes"] = minutes;
        return _data;
    }
}

class ApprovedBy {
    String? id;
    String? name;
    String? email;

    ApprovedBy({this.id, this.name, this.email});

    ApprovedBy.fromJson(Map<String, dynamic> json) {
        id = json["_id"];
        name = json["name"];
        email = json["email"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["_id"] = id;
        _data["name"] = name;
        _data["email"] = email;
        return _data;
    }
}