class SpvViewSubTaskModel {
  bool? success;
  Data? data;

  SpvViewSubTaskModel({this.success, this.data});

  SpvViewSubTaskModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = {};
    _data["success"] = success;
    if (data != null) {
      _data["data"] = data!.toJson();
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
  String? subProjectId;
  String? subProjectName;
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
  String? dueDate;
  String? responseRequiredBy;
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
  String? approvedBy;
  String? createdBy;
  String? createdDate;
  String? updatedDate;
  String? remarks;
  TimestampTracking? timestampTracking;
  Timeliness? timeliness;
  int? quantityExceededBy;
  String? quantityPerformance;
  TaskStatusFlags? taskStatusFlags;

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toString();
    title = json["title"]?.toString();
    description = json["description"]?.toString();
    specification = json["specification"]?.toString();
    projectId = json["project_id"]?.toString();
    projectName = json["project_name"]?.toString();
    projectCode = json["project_code"]?.toString();
    subProjectId = json["sub_project_id"]?.toString();
    subProjectName = json["sub_project_name"]?.toString();
    assignmentType = json["assignment_type"]?.toString();
    assignmentName = json["assignment_name"]?.toString();
    status = json["status"]?.toString();
    statusLabel = json["status_label"]?.toString();
    statusColor = json["status_color"]?.toString();
    progress = _parseInt(json["progress"]);
    isOverdue = json["is_overdue"];
    priority = json["priority"]?.toString();
    priorityLabel = json["priority_label"]?.toString();
    priorityColor = json["priority_color"]?.toString();
    inquiryType = json["inquiry_type"]?.toString();
    startDate = json["start_date"]?.toString();
    endDate = json["end_date"]?.toString();
    dueDate = json["due_date"]?.toString();
    responseRequiredBy = json["response_required_by"]?.toString();
    totalQuantity = _parseInt(json["total_quantity"]);
    coveredQuantity = _parseInt(json["covered_quantity"]);
    quantityType = json["quantity_type"]?.toString();
    unitSymbol = json["unit_symbol"]?.toString();
    sourceLocation = json["source_location"]?.toString();
    destinationLocation = json["destination_location"]?.toString();
    hasSubTasks = json["has_sub_tasks"];
    subTasksCount = _parseInt(json["sub_tasks_count"]);

    subTasks = json["sub_tasks"] == null
        ? null
        : (json["sub_tasks"] as List)
            .map((e) => SubTasks.fromJson(e))
            .toList();

    isApproved = json["is_approved"];
    approvedBy = json["approved_by"]?.toString();
    createdBy = json["created_by"]?.toString();
    createdDate = json["created_date"]?.toString();
    updatedDate = json["updated_date"]?.toString();
    remarks = json["remarks"]?.toString();

    timestampTracking = json["timestamp_tracking"] == null
        ? null
        : TimestampTracking.fromJson(json["timestamp_tracking"]);

    timeliness = json["timeliness"] == null
        ? null
        : Timeliness.fromJson(json["timeliness"]);

    quantityExceededBy = _parseInt(json["quantity_exceeded_by"]);
    quantityPerformance = json["quantity_performance"]?.toString();

    taskStatusFlags = json["task_status_flags"] == null
        ? null
        : TaskStatusFlags.fromJson(json["task_status_flags"]);
  }

  Map<String, dynamic> toJson() => {};
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

  SubTasks.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toString();
    title = json["title"]?.toString();
    specification = json["specification"]?.toString();
    description = json["description"]?.toString();
    distancePointA = json["distance_point_a"]?.toString();
    distancePointB = json["distance_point_b"]?.toString();
    totalQuantity = _parseInt(json["total_quantity"]);
    coveredQuantity = _parseInt(json["covered_quantity"]);
    quantityType = json["quantity_type"]?.toString();
    unitSymbol = json["unit_symbol"]?.toString();
    progressInputMode = json["progress_input_mode"]?.toString();
    progress = _parseInt(json["progress"]);
    status = json["status"]?.toString();
    statusColor = json["status_color"]?.toString();
    startDate = json["start_date"]?.toString();
    endDate = json["end_date"]?.toString();
    updatedByWorker = json["updated_by_worker"]?.toString();
    updatedDate = json["updated_date"]?.toString();
    remarks = json["remarks"]?.toString();
    sourceStartTimestamp = json["source_start_timestamp"]?.toString();
    destinationFinishTimestamp =
        json["destination_finish_timestamp"]?.toString();
    actualDurationMinutes =
        _parseInt(json["actual_duration_minutes"]);
    startedOnTime = json["started_on_time"]?.toString();
    finishedOnTime = json["finished_on_time"]?.toString();
    completionTimeliness =
        json["completion_timeliness"]?.toString();
    quantityExceededBy =
        _parseInt(json["quantity_exceeded_by"]);
  }
}

class TimestampTracking {
  String? sourceStartTimestamp;
  String? destinationFinishTimestamp;
  int? actualDurationMinutes;
  String? actualDurationHours;
  String? formattedSourceStart;
  String? formattedDestinationFinish;

  TimestampTracking.fromJson(Map<String, dynamic> json) {
    sourceStartTimestamp =
        json["source_start_timestamp"]?.toString();
    destinationFinishTimestamp =
        json["destination_finish_timestamp"]?.toString();
    actualDurationMinutes =
        _parseInt(json["actual_duration_minutes"]);
    actualDurationHours =
        json["actual_duration_hours"]?.toString();
    formattedSourceStart =
        json["formatted_source_start"]?.toString();
    formattedDestinationFinish =
        json["formatted_destination_finish"]?.toString();
  }
}

class Timeliness {
  String? startedOnTime;
  String? finishedOnTime;
  String? completionTimeliness;
  String? startedLabel;
  String? finishedLabel;
  String? completionLabel;

  Timeliness.fromJson(Map<String, dynamic> json) {
    startedOnTime = json["started_on_time"]?.toString();
    finishedOnTime = json["finished_on_time"]?.toString();
    completionTimeliness =
        json["completion_timeliness"]?.toString();
    startedLabel = json["started_label"]?.toString();
    finishedLabel = json["finished_label"]?.toString();
    completionLabel = json["completion_label"]?.toString();
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

  TaskStatusFlags.fromJson(Map<String, dynamic> json) {
    hasStarted = json["has_started"];
    hasFinished = json["has_finished"];
    isInProgress = json["is_in_progress"];
    isCompleted = json["is_completed"];
    isOnTime = json["is_on_time"];
    isEarly = json["is_early"];
    isDelayed = json["is_delayed"];
  }
}

/// 🔧 Common safe int parser
int? _parseInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  return int.tryParse(value.toString());
}
