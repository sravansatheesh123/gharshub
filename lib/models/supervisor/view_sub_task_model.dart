
class SpvViewSubTaskModel {
    bool? success;
    Data? data;

    SpvViewSubTaskModel({this.success, this.data});

    SpvViewSubTaskModel.fromJson(Map<String, dynamic> json) {
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
    String? id;
    String? title;
    String? description;
    String? specification;
    String? projectId;
    String? projectName;
    String? projectCode;
    dynamic subProjectId;
    dynamic subProjectName;
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
    List<SubTasks>? subTasks;
    bool? isApproved;
    dynamic approvedBy;
    String? createdBy;
    String? createdDate;
    String? updatedDate;
    String? remarks;
    TimestampTracking? timestampTracking;
    Timeliness? timeliness;
    int? quantityExceededBy;
    String? quantityPerformance;
    TaskStatusFlags? taskStatusFlags;

    Data({this.id, this.title, this.description, this.specification, this.projectId, this.projectName, this.projectCode, this.subProjectId, this.subProjectName, this.assignmentType, this.assignmentName, this.status, this.statusLabel, this.statusColor, this.progress, this.isOverdue, this.priority, this.priorityLabel, this.priorityColor, this.inquiryType, this.startDate, this.endDate, this.dueDate, this.responseRequiredBy, this.totalQuantity, this.coveredQuantity, this.quantityType, this.unitSymbol, this.sourceLocation, this.destinationLocation, this.hasSubTasks, this.subTasksCount, this.subTasks, this.isApproved, this.approvedBy, this.createdBy, this.createdDate, this.updatedDate, this.remarks, this.timestampTracking, this.timeliness, this.quantityExceededBy, this.quantityPerformance, this.taskStatusFlags});

    Data.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        title = json["title"];
        description = json["description"];
        specification = json["specification"];
        projectId = json["project_id"];
        projectName = json["project_name"];
        projectCode = json["project_code"];
        subProjectId = json["sub_project_id"];
        subProjectName = json["sub_project_name"];
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
        subTasks = json["sub_tasks"] == null ? null : (json["sub_tasks"] as List).map((e) => SubTasks.fromJson(e)).toList();
        isApproved = json["is_approved"];
        approvedBy = json["approved_by"];
        createdBy = json["created_by"];
        createdDate = json["created_date"];
        updatedDate = json["updated_date"];
        remarks = json["remarks"];
        timestampTracking = json["timestamp_tracking"] == null ? null : TimestampTracking.fromJson(json["timestamp_tracking"]);
        timeliness = json["timeliness"] == null ? null : Timeliness.fromJson(json["timeliness"]);
        quantityExceededBy = json["quantity_exceeded_by"];
        quantityPerformance = json["quantity_performance"];
        taskStatusFlags = json["task_status_flags"] == null ? null : TaskStatusFlags.fromJson(json["task_status_flags"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["title"] = title;
        _data["description"] = description;
        _data["specification"] = specification;
        _data["project_id"] = projectId;
        _data["project_name"] = projectName;
        _data["project_code"] = projectCode;
        _data["sub_project_id"] = subProjectId;
        _data["sub_project_name"] = subProjectName;
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
        if(subTasks != null) {
            _data["sub_tasks"] = subTasks?.map((e) => e.toJson()).toList();
        }
        _data["is_approved"] = isApproved;
        _data["approved_by"] = approvedBy;
        _data["created_by"] = createdBy;
        _data["created_date"] = createdDate;
        _data["updated_date"] = updatedDate;
        _data["remarks"] = remarks;
        if(timestampTracking != null) {
            _data["timestamp_tracking"] = timestampTracking?.toJson();
        }
        if(timeliness != null) {
            _data["timeliness"] = timeliness?.toJson();
        }
        _data["quantity_exceeded_by"] = quantityExceededBy;
        _data["quantity_performance"] = quantityPerformance;
        if(taskStatusFlags != null) {
            _data["task_status_flags"] = taskStatusFlags?.toJson();
        }
        return _data;
    }
}

class TaskStatusFlags {
    bool? hasStarted;
    bool? hasFinished;
    bool? isInProgress;
    bool? isCompleted;
    bool? isOnTime;
    bool? isEarly;
    bool? isDelayed;

    TaskStatusFlags({this.hasStarted, this.hasFinished, this.isInProgress, this.isCompleted, this.isOnTime, this.isEarly, this.isDelayed});

    TaskStatusFlags.fromJson(Map<String, dynamic> json) {
        hasStarted = json["has_started"];
        hasFinished = json["has_finished"];
        isInProgress = json["is_in_progress"];
        isCompleted = json["is_completed"];
        isOnTime = json["is_on_time"];
        isEarly = json["is_early"];
        isDelayed = json["is_delayed"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["has_started"] = hasStarted;
        _data["has_finished"] = hasFinished;
        _data["is_in_progress"] = isInProgress;
        _data["is_completed"] = isCompleted;
        _data["is_on_time"] = isOnTime;
        _data["is_early"] = isEarly;
        _data["is_delayed"] = isDelayed;
        return _data;
    }
}

class Timeliness {
    String? startedOnTime;
    String? finishedOnTime;
    String? completionTimeliness;
    String? startedLabel;
    String? finishedLabel;
    String? completionLabel;

    Timeliness({this.startedOnTime, this.finishedOnTime, this.completionTimeliness, this.startedLabel, this.finishedLabel, this.completionLabel});

    Timeliness.fromJson(Map<String, dynamic> json) {
        startedOnTime = json["started_on_time"];
        finishedOnTime = json["finished_on_time"];
        completionTimeliness = json["completion_timeliness"];
        startedLabel = json["started_label"];
        finishedLabel = json["finished_label"];
        completionLabel = json["completion_label"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["started_on_time"] = startedOnTime;
        _data["finished_on_time"] = finishedOnTime;
        _data["completion_timeliness"] = completionTimeliness;
        _data["started_label"] = startedLabel;
        _data["finished_label"] = finishedLabel;
        _data["completion_label"] = completionLabel;
        return _data;
    }
}

class TimestampTracking {
    String? sourceStartTimestamp;
    String? destinationFinishTimestamp;
    int? actualDurationMinutes;
    String? actualDurationHours;
    String? formattedSourceStart;
    String? formattedDestinationFinish;

    TimestampTracking({this.sourceStartTimestamp, this.destinationFinishTimestamp, this.actualDurationMinutes, this.actualDurationHours, this.formattedSourceStart, this.formattedDestinationFinish});

    TimestampTracking.fromJson(Map<String, dynamic> json) {
        sourceStartTimestamp = json["source_start_timestamp"];
        destinationFinishTimestamp = json["destination_finish_timestamp"];
        actualDurationMinutes = json["actual_duration_minutes"];
        actualDurationHours = json["actual_duration_hours"];
        formattedSourceStart = json["formatted_source_start"];
        formattedDestinationFinish = json["formatted_destination_finish"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["source_start_timestamp"] = sourceStartTimestamp;
        _data["destination_finish_timestamp"] = destinationFinishTimestamp;
        _data["actual_duration_minutes"] = actualDurationMinutes;
        _data["actual_duration_hours"] = actualDurationHours;
        _data["formatted_source_start"] = formattedSourceStart;
        _data["formatted_destination_finish"] = formattedDestinationFinish;
        return _data;
    }
}

class SubTasks {
    String? id;
    String? title;
    String? specification;
    String? description;
    String? distancePointA;
    String? distancePointB;
    int? totalQuantity;
    int? coveredQuantity;
    String? quantityType;
    String? unitSymbol;
    String? progressInputMode;
    int? progress;
    String? status;
    String? statusColor;
    String? startDate;
    String? endDate;
    String? updatedByWorker;
    String? updatedDate;
    String? remarks;
    String? sourceStartTimestamp;
    String? destinationFinishTimestamp;
    int? actualDurationMinutes;
    String? startedOnTime;
    String? finishedOnTime;
    String? completionTimeliness;
    int? quantityExceededBy;

    SubTasks({this.id, this.title, this.specification, this.description, this.distancePointA, this.distancePointB, this.totalQuantity, this.coveredQuantity, this.quantityType, this.unitSymbol, this.progressInputMode, this.progress, this.status, this.statusColor, this.startDate, this.endDate, this.updatedByWorker, this.updatedDate, this.remarks, this.sourceStartTimestamp, this.destinationFinishTimestamp, this.actualDurationMinutes, this.startedOnTime, this.finishedOnTime, this.completionTimeliness, this.quantityExceededBy});

    SubTasks.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        title = json["title"];
        specification = json["specification"];
        description = json["description"];
        distancePointA = json["distance_point_a"];
        distancePointB = json["distance_point_b"];
        totalQuantity = json["total_quantity"];
        coveredQuantity = json["covered_quantity"];
        quantityType = json["quantity_type"];
        unitSymbol = json["unit_symbol"];
        progressInputMode = json["progress_input_mode"];
        progress = json["progress"];
        status = json["status"];
        statusColor = json["status_color"];
        startDate = json["start_date"];
        endDate = json["end_date"];
        updatedByWorker = json["updated_by_worker"];
        updatedDate = json["updated_date"];
        remarks = json["remarks"];
        sourceStartTimestamp = json["source_start_timestamp"];
        destinationFinishTimestamp = json["destination_finish_timestamp"];
        actualDurationMinutes = json["actual_duration_minutes"];
        startedOnTime = json["started_on_time"];
        finishedOnTime = json["finished_on_time"];
        completionTimeliness = json["completion_timeliness"];
        quantityExceededBy = json["quantity_exceeded_by"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["title"] = title;
        _data["specification"] = specification;
        _data["description"] = description;
        _data["distance_point_a"] = distancePointA;
        _data["distance_point_b"] = distancePointB;
        _data["total_quantity"] = totalQuantity;
        _data["covered_quantity"] = coveredQuantity;
        _data["quantity_type"] = quantityType;
        _data["unit_symbol"] = unitSymbol;
        _data["progress_input_mode"] = progressInputMode;
        _data["progress"] = progress;
        _data["status"] = status;
        _data["status_color"] = statusColor;
        _data["start_date"] = startDate;
        _data["end_date"] = endDate;
        _data["updated_by_worker"] = updatedByWorker;
        _data["updated_date"] = updatedDate;
        _data["remarks"] = remarks;
        _data["source_start_timestamp"] = sourceStartTimestamp;
        _data["destination_finish_timestamp"] = destinationFinishTimestamp;
        _data["actual_duration_minutes"] = actualDurationMinutes;
        _data["started_on_time"] = startedOnTime;
        _data["finished_on_time"] = finishedOnTime;
        _data["completion_timeliness"] = completionTimeliness;
        _data["quantity_exceeded_by"] = quantityExceededBy;
        return _data;
    }
}