class SupervisorDashboardModel {
  final bool success;
  final SupervisorDashboardData data;

  SupervisorDashboardModel({
    required this.success,
    required this.data,
  });

  factory SupervisorDashboardModel.fromJson(Map<String, dynamic> json) {
    return SupervisorDashboardModel(
      success: json["success"] ?? false,
      data: SupervisorDashboardData.fromJson(json["data"] ?? {}),
    );
  }
}

class SupervisorDashboardData {
  final SupervisorStats stats;
  final List<SupervisorProject> projects;
  final String date;
  final String formattedDate;

  SupervisorDashboardData({
    required this.stats,
    required this.projects,
    required this.date,
    required this.formattedDate,
  });

  factory SupervisorDashboardData.fromJson(Map<String, dynamic> json) {
    return SupervisorDashboardData(
      stats: SupervisorStats.fromJson(json["stats"] ?? {}),
      projects: (json["projects"] as List? ?? [])
          .map((e) => SupervisorProject.fromJson(e))
          .toList(),
      date: json["date"] ?? "",
      formattedDate: json["formatted_date"] ?? "",
    );
  }
}

class SupervisorStats {
  final int totalAssigned;
  final int present;
  final int absent;
  final int onLeave;
  final int holiday;
  final int notMarked;

  final int totalProjects;
  final int activeProjects;
  final int onHoldProjects;
  final int completedProjects;

  final int totalPlannedManHours;

  final int absentToday;
  final int onLeaveToday;
  final int unmarkedToday;

  SupervisorStats({
    required this.totalAssigned,
    required this.present,
    required this.absent,
    required this.onLeave,
    required this.holiday,
    required this.notMarked,
    required this.totalProjects,
    required this.activeProjects,
    required this.onHoldProjects,
    required this.completedProjects,
    required this.totalPlannedManHours,
    required this.absentToday,
    required this.onLeaveToday,
    required this.unmarkedToday,
  });

  factory SupervisorStats.fromJson(Map<String, dynamic> json) {
    return SupervisorStats(
      totalAssigned: json["total_assigned"] ?? 0,
      present: json["present"] ?? 0,
      absent: json["absent"] ?? 0,
      onLeave: json["on_leave"] ?? 0,
      holiday: json["holiday"] ?? 0,
      notMarked: json["not_marked"] ?? 0,
      totalProjects: json["total_projects"] ?? 0,
      activeProjects: json["active_projects"] ?? 0,
      onHoldProjects: json["on_hold_projects"] ?? 0,
      completedProjects: json["completed_projects"] ?? 0,
      totalPlannedManHours: json["total_planned_man_hours"] ?? 0,
      absentToday: json["absent_today"] ?? 0,
      onLeaveToday: json["on_leave_today"] ?? 0,
      unmarkedToday: json["unmarked_today"] ?? 0,
    );
  }
}

class SupervisorProject {
  final String id;
  final String name;
  final String code;
  final String status;
  final int progress;

  SupervisorProject({
    required this.id,
    required this.name,
    required this.code,
    required this.status,
    required this.progress,
  });

  factory SupervisorProject.fromJson(Map<String, dynamic> json) {
    return SupervisorProject(
      id: json["_id"] ?? json["id"] ?? "",
      name: json["name"] ?? "",
      code: json["code"] ?? "",
      status: json["status"] ?? "",
      progress: json["progress"] ?? 0,
    );
  }
}
