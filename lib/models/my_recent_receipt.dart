
class RecentReceiptModel {
    bool? success;
    Data? data;

    RecentReceiptModel({this.success, this.data});

    RecentReceiptModel.fromJson(Map<String, dynamic> json) {
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
    SalaryDetails? salaryDetails;
    Receipt? receipt;
    bool? hasData;

    RecentReceipts({this.month, this.year, this.monthName, this.summary, this.salaryDetails, this.receipt, this.hasData});

    RecentReceipts.fromJson(Map<String, dynamic> json) {
        month = json["month"];
        year = json["year"];
        monthName = json["monthName"];
        summary = json["summary"] == null ? null : Summary.fromJson(json["summary"]);
        salaryDetails = json["salaryDetails"] == null ? null : SalaryDetails.fromJson(json["salaryDetails"]);
        receipt = json["receipt"] == null ? null : Receipt.fromJson(json["receipt"]);
        hasData = json["hasData"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["month"] = month;
        _data["year"] = year;
        _data["monthName"] = monthName;
        if(summary != null) {
            _data["summary"] = summary?.toJson();
        }
        if(salaryDetails != null) {
            _data["salaryDetails"] = salaryDetails?.toJson();
        }
        if(receipt != null) {
            _data["receipt"] = receipt?.toJson();
        }
        _data["hasData"] = hasData;
        return _data;
    }
}

class Receipt {
    String? receiptNumber;
    String? signatureStatus;
    String? signatureType;
    String? signedAt;
    String? receiptStatus;
    String? fileName;
    String? generatedAt;
    String? s3Key;
    String? downloadUrl;
    bool? storedInS3;

    Receipt({this.receiptNumber, this.signatureStatus, this.signatureType, this.signedAt, this.receiptStatus, this.fileName, this.generatedAt, this.s3Key, this.downloadUrl, this.storedInS3});

    Receipt.fromJson(Map<String, dynamic> json) {
        receiptNumber = json["receiptNumber"];
        signatureStatus = json["signatureStatus"];
        signatureType = json["signatureType"];
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
        _data["signatureType"] = signatureType;
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

class SalaryDetails {
    int? basicSalary;
    int? normalOvertimeAmount;
    int? holidayOvertimeAmount;
    int? otherPaymentsTotal;
    int? otherDeductionsTotal;
    int? grossSalary;
    int? totalDeductions;
    int? netPayable;
    String? paymentMode;

    SalaryDetails({this.basicSalary, this.normalOvertimeAmount, this.holidayOvertimeAmount, this.otherPaymentsTotal, this.otherDeductionsTotal, this.grossSalary, this.totalDeductions, this.netPayable, this.paymentMode});

    SalaryDetails.fromJson(Map<String, dynamic> json) {
        basicSalary = json["basicSalary"];
        normalOvertimeAmount = json["normalOvertimeAmount"];
        holidayOvertimeAmount = json["holidayOvertimeAmount"];
        otherPaymentsTotal = json["otherPaymentsTotal"];
        otherDeductionsTotal = json["otherDeductionsTotal"];
        grossSalary = json["grossSalary"];
        totalDeductions = json["totalDeductions"];
        netPayable = json["netPayable"];
        paymentMode = json["paymentMode"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["basicSalary"] = basicSalary;
        _data["normalOvertimeAmount"] = normalOvertimeAmount;
        _data["holidayOvertimeAmount"] = holidayOvertimeAmount;
        _data["otherPaymentsTotal"] = otherPaymentsTotal;
        _data["otherDeductionsTotal"] = otherDeductionsTotal;
        _data["grossSalary"] = grossSalary;
        _data["totalDeductions"] = totalDeductions;
        _data["netPayable"] = netPayable;
        _data["paymentMode"] = paymentMode;
        return _data;
    }
}

class Summary {
    int? daysPresent;
    int? daysWorked;
    int? totalWorkHours;
    int? totalNormalOvertime;
    int? totalHolidayOvertime;
    int? basicSalary;
    int? totalEarnings;
    int? totalDeductions;
    int? netPayable;

    Summary({this.daysPresent, this.daysWorked, this.totalWorkHours, this.totalNormalOvertime, this.totalHolidayOvertime, this.basicSalary, this.totalEarnings, this.totalDeductions, this.netPayable});

    Summary.fromJson(Map<String, dynamic> json) {
        daysPresent = json["daysPresent"];
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
        _data["daysPresent"] = daysPresent;
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
    dynamic projectRoleId;
    int? totalSalary;

    Employee({this.id, this.employeeId, this.name, this.role, this.phone, this.department, this.projectRoleId, this.totalSalary});

    Employee.fromJson(Map<String, dynamic> json) {
        id = json["_id"];
        employeeId = json["employee_id"];
        name = json["name"];
        role = json["role"];
        phone = json["phone"];
        department = json["department"];
        projectRoleId = json["project_role_id"];
        totalSalary = json["total_salary"];
        id = json["id"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["_id"] = id;
        _data["employee_id"] = employeeId;
        _data["name"] = name;
        _data["role"] = role;
        _data["phone"] = phone;
        _data["department"] = department;
        _data["project_role_id"] = projectRoleId;
        _data["total_salary"] = totalSalary;
        _data["id"] = id;
        return _data;
    }
}