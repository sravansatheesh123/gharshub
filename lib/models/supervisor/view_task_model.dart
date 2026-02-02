
class SpvViewTaskModel {
    bool? success;
    Data? data;

    SpvViewTaskModel({this.success, this.data});

    SpvViewTaskModel.fromJson(Map<String, dynamic> json) {
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
    List<Tasks>? tasks;
    ProjectDetails? projectDetails;
    Stats? stats;
    Pagination? pagination;
    Filters? filters;

    Data({this.tasks, this.projectDetails, this.stats, this.pagination, this.filters});

    Data.fromJson(Map<String, dynamic> json) {
        tasks = json["tasks"] == null ? null : (json["tasks"] as List).map((e) => Tasks.fromJson(e)).toList();
        projectDetails = json["project_details"] == null ? null : ProjectDetails.fromJson(json["project_details"]);
        stats = json["stats"] == null ? null : Stats.fromJson(json["stats"]);
        pagination = json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]);
        filters = json["filters"] == null ? null : Filters.fromJson(json["filters"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(tasks != null) {
            _data["tasks"] = tasks?.map((e) => e.toJson()).toList();
        }
        if(projectDetails != null) {
            _data["project_details"] = projectDetails?.toJson();
        }
        if(stats != null) {
            _data["stats"] = stats?.toJson();
        }
        if(pagination != null) {
            _data["pagination"] = pagination?.toJson();
        }
        if(filters != null) {
            _data["filters"] = filters?.toJson();
        }
        return _data;
    }
}

class Filters {
    String? projectId;
    String? type;

    Filters({this.projectId, this.type});

    Filters.fromJson(Map<String, dynamic> json) {
        projectId = json["projectId"];
        type = json["type"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["projectId"] = projectId;
        _data["type"] = type;
        return _data;
    }
}

class Pagination {
    int? current;
    int? pages;
    int? total;
    int? limit;

    Pagination({this.current, this.pages, this.total, this.limit});

    Pagination.fromJson(Map<String, dynamic> json) {
        current = json["current"];
        pages = json["pages"];
        total = json["total"];
        limit = json["limit"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["current"] = current;
        _data["pages"] = pages;
        _data["total"] = total;
        _data["limit"] = limit;
        return _data;
    }
}

class Stats {
    int? totalTasks;
    int? averageProgress;
    StatusCounts? statusCounts;
    int? overdue;
    PriorityCounts? priorityCounts;

    Stats({this.totalTasks, this.averageProgress, this.statusCounts, this.overdue, this.priorityCounts});

    Stats.fromJson(Map<String, dynamic> json) {
        totalTasks = json["total_tasks"];
        averageProgress = json["average_progress"];
        statusCounts = json["status_counts"] == null ? null : StatusCounts.fromJson(json["status_counts"]);
        overdue = json["overdue"];
        priorityCounts = json["priority_counts"] == null ? null : PriorityCounts.fromJson(json["priority_counts"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["total_tasks"] = totalTasks;
        _data["average_progress"] = averageProgress;
        if(statusCounts != null) {
            _data["status_counts"] = statusCounts?.toJson();
        }
        _data["overdue"] = overdue;
        if(priorityCounts != null) {
            _data["priority_counts"] = priorityCounts?.toJson();
        }
        return _data;
    }
}

class PriorityCounts {
    int? urgent;
    int? high;
    int? medium;
    int? low;

    PriorityCounts({this.urgent, this.high, this.medium, this.low});

    PriorityCounts.fromJson(Map<String, dynamic> json) {
        urgent = json["urgent"];
        high = json["high"];
        medium = json["medium"];
        low = json["low"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["urgent"] = urgent;
        _data["high"] = high;
        _data["medium"] = medium;
        _data["low"] = low;
        return _data;
    }
}

class StatusCounts {
    int? pending;
    int? inProgress;
    int? responded;
    int? completed;

    StatusCounts({this.pending, this.inProgress, this.responded, this.completed});

    StatusCounts.fromJson(Map<String, dynamic> json) {
        pending = json["pending"];
        inProgress = json["in_progress"];
        responded = json["responded"];
        completed = json["completed"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["pending"] = pending;
        _data["in_progress"] = inProgress;
        _data["responded"] = responded;
        _data["completed"] = completed;
        return _data;
    }
}

class ProjectDetails {
    String? id;
    String? projectName;
    String? projectCode;
    ClientName? clientName;

    ProjectDetails({this.id, this.projectName, this.projectCode, this.clientName});

    ProjectDetails.fromJson(Map<String, dynamic> json) {
        id = json["_id"];
        projectName = json["project_name"];
        projectCode = json["project_code"];
        clientName = json["client_name"] == null ? null : ClientName.fromJson(json["client_name"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["_id"] = id;
        _data["project_name"] = projectName;
        _data["project_code"] = projectCode;
        if(clientName != null) {
            _data["client_name"] = clientName?.toJson();
        }
        return _data;
    }
}

class ClientName {
    String? id;

    ClientName({this.id});

    ClientName.fromJson(Map<String, dynamic> json) {
        id = json["_id"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["_id"] = id;
        return _data;
    }
}

class Tasks {
    String? id;
    String? title;
    String? sourceStartTimestamp;
    String? destinationFinishTimestamp;
    int? actualDurationMinutes;
    String? startedOnTime;
    String? finishedOnTime;
    String? completionTimeliness;
    int? quantityExceededBy;
    String? description;
    String? specification;
    String? projectId;
    String? projectName;
    String? projectCode;
    dynamic subProjectId;
    String? assignmentType;
    String? assignmentName;
    String? status;
    String? statusLabel;
    String? statusColor;
    int? progress;
    bool? isOverdue;
    String? priority;
    String? priorityLabel;
    String? priorityColor;
    String? inquiryType;
    String? startDate;
    String? endDate;
    dynamic dueDate;
    dynamic responseRequiredBy;
    int? totalQuantity;
    int? coveredQuantity;
    String? quantityType;
    String? unitSymbol;
    String? sourceLocation;
    String? destinationLocation;
    bool? hasSubTasks;
    int? subTasksCount;
    String? createdBy;
    String? createdDate;
    String? updatedDate;
    bool? isApproved;
    String? displayInfo;

    Tasks({this.id, this.title, this.sourceStartTimestamp, this.destinationFinishTimestamp, this.actualDurationMinutes, this.startedOnTime, this.finishedOnTime, this.completionTimeliness, this.quantityExceededBy, this.description, this.specification, this.projectId, this.projectName, this.projectCode, this.subProjectId, this.assignmentType, this.assignmentName, this.status, this.statusLabel, this.statusColor, this.progress, this.isOverdue, this.priority, this.priorityLabel, this.priorityColor, this.inquiryType, this.startDate, this.endDate, this.dueDate, this.responseRequiredBy, this.totalQuantity, this.coveredQuantity, this.quantityType, this.unitSymbol, this.sourceLocation, this.destinationLocation, this.hasSubTasks, this.subTasksCount, this.createdBy, this.createdDate, this.updatedDate, this.isApproved, this.displayInfo});

    Tasks.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        title = json["title"];
        sourceStartTimestamp = json["source_start_timestamp"];
        destinationFinishTimestamp = json["destination_finish_timestamp"];
        actualDurationMinutes = json["actual_duration_minutes"];
        startedOnTime = json["started_on_time"];
        finishedOnTime = json["finished_on_time"];
        completionTimeliness = json["completion_timeliness"];
        quantityExceededBy = json["quantity_exceeded_by"];
        description = json["description"];
        specification = json["specification"];
        projectId = json["project_id"];
        projectName = json["project_name"];
        projectCode = json["project_code"];
        subProjectId = json["sub_project_id"];
        assignmentType = json["assignment_type"];
        assignmentName = json["assignment_name"];
        status = json["status"];
        statusLabel = json["status_label"];
        statusColor = json["status_color"];
        progress = json["progress"];
        isOverdue = json["is_overdue"];
        priority = json["priority"];
        priorityLabel = json["priority_label"];
        priorityColor = json["priority_color"];
        inquiryType = json["inquiry_type"];
        startDate = json["start_date"];
        endDate = json["end_date"];
        dueDate = json["due_date"];
        responseRequiredBy = json["response_required_by"];
        totalQuantity = json["total_quantity"];
        coveredQuantity = json["covered_quantity"];
        quantityType = json["quantity_type"];
        unitSymbol = json["unit_symbol"];
        sourceLocation = json["source_location"];
        destinationLocation = json["destination_location"];
        hasSubTasks = json["has_sub_tasks"];
        subTasksCount = json["sub_tasks_count"];
        createdBy = json["created_by"];
        createdDate = json["created_date"];
        updatedDate = json["updated_date"];
        isApproved = json["is_approved"];
        displayInfo = json["display_info"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["title"] = title;
        _data["source_start_timestamp"] = sourceStartTimestamp;
        _data["destination_finish_timestamp"] = destinationFinishTimestamp;
        _data["actual_duration_minutes"] = actualDurationMinutes;
        _data["started_on_time"] = startedOnTime;
        _data["finished_on_time"] = finishedOnTime;
        _data["completion_timeliness"] = completionTimeliness;
        _data["quantity_exceeded_by"] = quantityExceededBy;
        _data["description"] = description;
        _data["specification"] = specification;
        _data["project_id"] = projectId;
        _data["project_name"] = projectName;
        _data["project_code"] = projectCode;
        _data["sub_project_id"] = subProjectId;
        _data["assignment_type"] = assignmentType;
        _data["assignment_name"] = assignmentName;
        _data["status"] = status;
        _data["status_label"] = statusLabel;
        _data["status_color"] = statusColor;
        _data["progress"] = progress;
        _data["is_overdue"] = isOverdue;
        _data["priority"] = priority;
        _data["priority_label"] = priorityLabel;
        _data["priority_color"] = priorityColor;
        _data["inquiry_type"] = inquiryType;
        _data["start_date"] = startDate;
        _data["end_date"] = endDate;
        _data["due_date"] = dueDate;
        _data["response_required_by"] = responseRequiredBy;
        _data["total_quantity"] = totalQuantity;
        _data["covered_quantity"] = coveredQuantity;
        _data["quantity_type"] = quantityType;
        _data["unit_symbol"] = unitSymbol;
        _data["source_location"] = sourceLocation;
        _data["destination_location"] = destinationLocation;
        _data["has_sub_tasks"] = hasSubTasks;
        _data["sub_tasks_count"] = subTasksCount;
        _data["created_by"] = createdBy;
        _data["created_date"] = createdDate;
        _data["updated_date"] = updatedDate;
        _data["is_approved"] = isApproved;
        _data["display_info"] = displayInfo;
        return _data;
    }
}