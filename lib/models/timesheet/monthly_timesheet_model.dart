class MonthlyTimesheetResponse {
  final bool success;
  final MonthlyTimesheetData? data;

  MonthlyTimesheetResponse({
    required this.success,
    this.data,
  });

  factory MonthlyTimesheetResponse.fromJson(Map<String, dynamic> json) {
    return MonthlyTimesheetResponse(
      success: json["success"] == true,
      data: json["data"] == null
          ? null
          : MonthlyTimesheetData.fromJson(json["data"] as Map<String, dynamic>),
    );
  }
}

class MonthlyTimesheetData {
  final List<TimesheetItem> timesheet;
  final int month;
  final int year;
  final WorkSchedule? workSchedule;
  final int totalRecords;

  MonthlyTimesheetData({
    required this.timesheet,
    required this.month,
    required this.year,
    required this.workSchedule,
    required this.totalRecords,
  });

  factory MonthlyTimesheetData.fromJson(Map<String, dynamic> json) {
    int toInt(dynamic v) {
      if (v == null) return 0;
      if (v is int) return v;
      if (v is double) return v.toInt();
      return int.tryParse(v.toString()) ?? 0;
    }

    return MonthlyTimesheetData(
      timesheet: (json["timesheet"] as List? ?? [])
          .map((e) => TimesheetItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      month: toInt(json["month"]),
      year: toInt(json["year"]),
      workSchedule: json["workSchedule"] == null
          ? null
          : WorkSchedule.fromJson(json["workSchedule"] as Map<String, dynamic>),
      totalRecords: toInt(json["totalRecords"]),
    );
  }
}

class TimesheetItem {
  final String date;
  final String dayOfWeek;
  final String punchIn;
  final String punchOut;
  final String lateArrival;
  final String earlyExit;
  final String normalOT;
  final String holidayOT;
  final String status;
  final bool isHoliday;

  final bool isOnLeave;
  final String leaveReason;
  final String totalHours;
  final bool hasPunchRecord;
  final String punchStatus;

  TimesheetItem({
    required this.date,
    required this.dayOfWeek,
    required this.punchIn,
    required this.punchOut,
    required this.lateArrival,
    required this.earlyExit,
    required this.normalOT,
    required this.holidayOT,
    required this.status,
    required this.isHoliday,
    required this.isOnLeave,
    required this.leaveReason,
    required this.totalHours,
    required this.hasPunchRecord,
    required this.punchStatus,
  });

  factory TimesheetItem.fromJson(Map<String, dynamic> json) {
    return TimesheetItem(
      date: (json["date"] ?? "-").toString(),
      dayOfWeek: (json["dayOfWeek"] ?? "-").toString(),
      punchIn: (json["punchIn"] ?? "-").toString(),
      punchOut: (json["punchOut"] ?? "-").toString(),
      lateArrival: (json["lateArrival"] ?? "-").toString(),
      earlyExit: (json["earlyExit"] ?? "-").toString(),
      normalOT: (json["normalOT"] ?? "-").toString(),
      holidayOT: (json["holidayOT"] ?? "-").toString(),
      status: (json["status"] ?? "-").toString(),
      isHoliday: json["isHoliday"] == true,
      isOnLeave: json["isOnLeave"] == true,
      leaveReason: (json["leaveReason"] ?? "").toString(),
      totalHours: (json["totalHours"] ?? "-").toString(),
      hasPunchRecord: json["hasPunchRecord"] == true,
      punchStatus: (json["punchStatus"] ?? "-").toString(),
    );
  }
}

class WorkSchedule {
  final String startTime;
  final String endTime;

  WorkSchedule({
    required this.startTime,
    required this.endTime,
  });

  factory WorkSchedule.fromJson(Map<String, dynamic> json) {
    return WorkSchedule(
      startTime: (json["startTime"] ?? "-").toString(),
      endTime: (json["endTime"] ?? "-").toString(),
    );
  }
}
