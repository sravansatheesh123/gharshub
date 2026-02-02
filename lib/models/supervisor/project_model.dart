
class SpvProjectModel {
    bool? success;
    Data? data;

    SpvProjectModel({this.success, this.data});

    SpvProjectModel.fromJson(Map<String, dynamic> json) {
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
    List<Assignments>? assignments;
    Stats? stats;
    Summary? summary;

    Data({this.assignments, this.stats, this.summary});

    Data.fromJson(Map<String, dynamic> json) {
        assignments = json["assignments"] == null ? null : (json["assignments"] as List).map((e) => Assignments.fromJson(e)).toList();
        stats = json["stats"] == null ? null : Stats.fromJson(json["stats"]);
        summary = json["summary"] == null ? null : Summary.fromJson(json["summary"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(assignments != null) {
            _data["assignments"] = assignments?.map((e) => e.toJson()).toList();
        }
        if(stats != null) {
            _data["stats"] = stats?.toJson();
        }
        if(summary != null) {
            _data["summary"] = summary?.toJson();
        }
        return _data;
    }
}

class Summary {
    int? onTrack;
    int? atRisk;
    int? moderate;
    int? onHold;
    int? completed;
    int? cancelled;
    int? draft;

    Summary({this.onTrack, this.atRisk, this.moderate, this.onHold, this.completed, this.cancelled, this.draft});

    Summary.fromJson(Map<String, dynamic> json) {
        onTrack = json["on_track"];
        atRisk = json["at_risk"];
        moderate = json["moderate"];
        onHold = json["on_hold"];
        completed = json["completed"];
        cancelled = json["cancelled"];
        draft = json["draft"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["on_track"] = onTrack;
        _data["at_risk"] = atRisk;
        _data["moderate"] = moderate;
        _data["on_hold"] = onHold;
        _data["completed"] = completed;
        _data["cancelled"] = cancelled;
        _data["draft"] = draft;
        return _data;
    }
}

class Stats {
    int? totalAssignments;
    int? projectsCount;
    int? subprojectsCount;
    int? activeAssignments;
    int? onHoldAssignments;
    int? completedAssignments;
    int? cancelledAssignments;
    int? draftAssignments;
    int? totalTasks;
    int? completedTasks;
    int? overdueTasks;
    int? pendingTasks;
    int? overallProgress;
    int? totalAssignedPeople;

    Stats({this.totalAssignments, this.projectsCount, this.subprojectsCount, this.activeAssignments, this.onHoldAssignments, this.completedAssignments, this.cancelledAssignments, this.draftAssignments, this.totalTasks, this.completedTasks, this.overdueTasks, this.pendingTasks, this.overallProgress, this.totalAssignedPeople});

    Stats.fromJson(Map<String, dynamic> json) {
        totalAssignments = json["total_assignments"];
        projectsCount = json["projects_count"];
        subprojectsCount = json["subprojects_count"];
        activeAssignments = json["active_assignments"];
        onHoldAssignments = json["on_hold_assignments"];
        completedAssignments = json["completed_assignments"];
        cancelledAssignments = json["cancelled_assignments"];
        draftAssignments = json["draft_assignments"];
        totalTasks = json["total_tasks"];
        completedTasks = json["completed_tasks"];
        overdueTasks = json["overdue_tasks"];
        pendingTasks = json["pending_tasks"];
        overallProgress = json["overall_progress"];
        totalAssignedPeople = json["total_assigned_people"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["total_assignments"] = totalAssignments;
        _data["projects_count"] = projectsCount;
        _data["subprojects_count"] = subprojectsCount;
        _data["active_assignments"] = activeAssignments;
        _data["on_hold_assignments"] = onHoldAssignments;
        _data["completed_assignments"] = completedAssignments;
        _data["cancelled_assignments"] = cancelledAssignments;
        _data["draft_assignments"] = draftAssignments;
        _data["total_tasks"] = totalTasks;
        _data["completed_tasks"] = completedTasks;
        _data["overdue_tasks"] = overdueTasks;
        _data["pending_tasks"] = pendingTasks;
        _data["overall_progress"] = overallProgress;
        _data["total_assigned_people"] = totalAssignedPeople;
        return _data;
    }
}

class Assignments {
    String? id;
    String? type;
    String? title;
    String? code;
    String? supervisor;
    String? status;
    String? statusLabel;
    String? statusColor;
    int? progress;
    String? assigned;
    int? completed;
    int? overdue;
    int? pending;
    String? clientName;
    String? projectType;
    String? mainContractor;
    String? subcontractor;
    String? startDate;
    String? endDate;
    int? totalDuration;
    int? plannedManHours;
    int? quotedPrice;
    int? plannedCost;
    String? displayLabel;
    String? displayType;

    Assignments({this.id, this.type, this.title, this.code, this.supervisor, this.status, this.statusLabel, this.statusColor, this.progress, this.assigned, this.completed, this.overdue, this.pending, this.clientName, this.projectType, this.mainContractor, this.subcontractor, this.startDate, this.endDate, this.totalDuration, this.plannedManHours, this.quotedPrice, this.plannedCost, this.displayLabel, this.displayType});

    Assignments.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        type = json["type"];
        title = json["title"];
        code = json["code"];
        supervisor = json["supervisor"];
        status = json["status"];
        statusLabel = json["statusLabel"];
        statusColor = json["statusColor"];
        progress = json["progress"];
        assigned = json["assigned"];
        completed = json["completed"];
        overdue = json["overdue"];
        pending = json["pending"];
        clientName = json["client_name"];
        projectType = json["project_type"];
        mainContractor = json["main_contractor"];
        subcontractor = json["subcontractor"];
        startDate = json["start_date"];
        endDate = json["end_date"];
        totalDuration = json["total_duration"];
        plannedManHours = json["planned_man_hours"];
        quotedPrice = json["quoted_price"];
        plannedCost = json["planned_cost"];
        displayLabel = json["display_label"];
        displayType = json["display_type"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["type"] = type;
        _data["title"] = title;
        _data["code"] = code;
        _data["supervisor"] = supervisor;
        _data["status"] = status;
        _data["statusLabel"] = statusLabel;
        _data["statusColor"] = statusColor;
        _data["progress"] = progress;
        _data["assigned"] = assigned;
        _data["completed"] = completed;
        _data["overdue"] = overdue;
        _data["pending"] = pending;
        _data["client_name"] = clientName;
        _data["project_type"] = projectType;
        _data["main_contractor"] = mainContractor;
        _data["subcontractor"] = subcontractor;
        _data["start_date"] = startDate;
        _data["end_date"] = endDate;
        _data["total_duration"] = totalDuration;
        _data["planned_man_hours"] = plannedManHours;
        _data["quoted_price"] = quotedPrice;
        _data["planned_cost"] = plannedCost;
        _data["display_label"] = displayLabel;
        _data["display_type"] = displayType;
        return _data;
    }
}