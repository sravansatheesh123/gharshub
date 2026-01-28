
class AccessableReceiptModel {
    bool? success;
    Data? data;

    AccessableReceiptModel({this.success, this.data});

    AccessableReceiptModel.fromJson(Map<String, dynamic> json) {
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
    Employee? employee;
    List<RecentReceipts>? recentReceipts;
    int? count;

    Data({this.employee, this.recentReceipts, this.count});

    Data.fromJson(Map<String, dynamic> json) {
        employee = json["employee"] == null ? null : Employee.fromJson(json["employee"]);
        recentReceipts = json["recentReceipts"] == null ? null : (json["recentReceipts"] as List).map((e) => RecentReceipts.fromJson(e)).toList();
        count = json["count"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(employee != null) {
            _data["employee"] = employee?.toJson();
        }
        if(recentReceipts != null) {
            _data["recentReceipts"] = recentReceipts?.map((e) => e.toJson()).toList();
        }
        _data["count"] = count;
        return _data;
    }
}

class RecentReceipts {
    int? month;
    int? year;
    String? monthName;
    Summary? summary;
    Receipt? receipt;
    AccessInfo? accessInfo;

    RecentReceipts({this.month, this.year, this.monthName, this.summary, this.receipt, this.accessInfo});

    RecentReceipts.fromJson(Map<String, dynamic> json) {
        month = json["month"];
        year = json["year"];
        monthName = json["monthName"];
        summary = json["summary"] == null ? null : Summary.fromJson(json["summary"]);
        receipt = json["receipt"] == null ? null : Receipt.fromJson(json["receipt"]);
        accessInfo = json["accessInfo"] == null ? null : AccessInfo.fromJson(json["accessInfo"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["month"] = month;
        _data["year"] = year;
        _data["monthName"] = monthName;
        if(summary != null) {
            _data["summary"] = summary?.toJson();
        }
        if(receipt != null) {
            _data["receipt"] = receipt?.toJson();
        }
        if(accessInfo != null) {
            _data["accessInfo"] = accessInfo?.toJson();
        }
        return _data;
    }
}

class AccessInfo {
    bool? isTemporaryAccess;
    bool? isRecentMonth;

    AccessInfo({this.isTemporaryAccess, this.isRecentMonth});

    AccessInfo.fromJson(Map<String, dynamic> json) {
        isTemporaryAccess = json["isTemporaryAccess"];
        isRecentMonth = json["isRecentMonth"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["isTemporaryAccess"] = isTemporaryAccess;
        _data["isRecentMonth"] = isRecentMonth;
        return _data;
    }
}

class Receipt {
    String? receiptNumber;
    String? signatureStatus;
    String? signedAt;
    String? receiptStatus;
    String? fileName;
    String? generatedAt;
    String? s3Key;
    String? downloadUrl;
    bool? storedInS3;

    Receipt({this.receiptNumber, this.signatureStatus, this.signedAt, this.receiptStatus, this.fileName, this.generatedAt, this.s3Key, this.downloadUrl, this.storedInS3});

    Receipt.fromJson(Map<String, dynamic> json) {
        receiptNumber = json["receiptNumber"];
        signatureStatus = json["signatureStatus"];
        signedAt = json["signedAt"];
        receiptStatus = json["receiptStatus"];
        fileName = json["fileName"];
        generatedAt = json["generatedAt"];
        s3Key = json["s3Key"];
        downloadUrl = json["downloadUrl"];
        storedInS3 = json["storedInS3"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["receiptNumber"] = receiptNumber;
        _data["signatureStatus"] = signatureStatus;
        _data["signedAt"] = signedAt;
        _data["receiptStatus"] = receiptStatus;
        _data["fileName"] = fileName;
        _data["generatedAt"] = generatedAt;
        _data["s3Key"] = s3Key;
        _data["downloadUrl"] = downloadUrl;
        _data["storedInS3"] = storedInS3;
        return _data;
    }
}

class Summary {
    int? daysWorked;
    int? totalWorkHours;
    int? totalNormalOvertime;
    int? totalHolidayOvertime;
    int? basicSalary;
    int? totalEarnings;
    int? totalDeductions;
    int? netPayable;

    Summary({this.daysWorked, this.totalWorkHours, this.totalNormalOvertime, this.totalHolidayOvertime, this.basicSalary, this.totalEarnings, this.totalDeductions, this.netPayable});

    Summary.fromJson(Map<String, dynamic> json) {
        daysWorked = json["daysWorked"];
        totalWorkHours = json["totalWorkHours"];
        totalNormalOvertime = json["totalNormalOvertime"];
        totalHolidayOvertime = json["totalHolidayOvertime"];
        basicSalary = json["basicSalary"];
        totalEarnings = json["totalEarnings"];
        totalDeductions = json["totalDeductions"];
        netPayable = json["netPayable"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["daysWorked"] = daysWorked;
        _data["totalWorkHours"] = totalWorkHours;
        _data["totalNormalOvertime"] = totalNormalOvertime;
        _data["totalHolidayOvertime"] = totalHolidayOvertime;
        _data["basicSalary"] = basicSalary;
        _data["totalEarnings"] = totalEarnings;
        _data["totalDeductions"] = totalDeductions;
        _data["netPayable"] = netPayable;
        return _data;
    }
}

class Employee {
    String? id;
    String? employeeId;
    String? name;
    String? role;
    dynamic phone;
    String? department;

    Employee({this.id, this.employeeId, this.name, this.role, this.phone, this.department});

    Employee.fromJson(Map<String, dynamic> json) {
        id = json["_id"];
        employeeId = json["employee_id"];
        name = json["name"];
        role = json["role"];
        phone = json["phone"];
        department = json["department"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["_id"] = id;
        _data["employee_id"] = employeeId;
        _data["name"] = name;
        _data["role"] = role;
        _data["phone"] = phone;
        _data["department"] = department;
        return _data;
    }
}