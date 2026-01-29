
class ProjectListModel {
    bool? success;
    List<Data>? data;
    Debug? debug;

    ProjectListModel({this.success, this.data, this.debug});

    ProjectListModel.fromJson(Map<String, dynamic> json) {
        success = json["success"];
        data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
        debug = json["debug"] == null ? null : Debug.fromJson(json["debug"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["success"] = success;
        if(data != null) {
            _data["data"] = data?.map((e) => e.toJson()).toList();
        }
        if(debug != null) {
            _data["debug"] = debug?.toJson();
        }
        return _data;
    }
}

class Debug {
    int? totalAssignments;
    int? hasSubprojectsCount;
    int? projectsCount;
    int? subprojectsCount;

    Debug({this.totalAssignments, this.hasSubprojectsCount, this.projectsCount, this.subprojectsCount});

    Debug.fromJson(Map<String, dynamic> json) {
        totalAssignments = json["total_assignments"];
        hasSubprojectsCount = json["has_subprojects_count"];
        projectsCount = json["projects_count"];
        subprojectsCount = json["subprojects_count"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["total_assignments"] = totalAssignments;
        _data["has_subprojects_count"] = hasSubprojectsCount;
        _data["projects_count"] = projectsCount;
        _data["subprojects_count"] = subprojectsCount;
        return _data;
    }
}

class Data {
    String? id;
    String? name;
    String? projectCode;
    String? type;
    String? status;
    int? technicianCount;
    bool? hasSubprojects;
    int? plannedHours;
    int? actualHours;

    Data({this.id, this.name, this.projectCode, this.type, this.status, this.technicianCount, this.hasSubprojects, this.plannedHours, this.actualHours});

    Data.fromJson(Map<String, dynamic> json) {
        id = json["_id"];
        name = json["name"];
        projectCode = json["project_code"];
        type = json["type"];
        status = json["status"];
        technicianCount = json["technician_count"];
        hasSubprojects = json["has_subprojects"];
        plannedHours = json["planned_hours"];
        actualHours = json["actual_hours"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["_id"] = id;
        _data["name"] = name;
        _data["project_code"] = projectCode;
        _data["type"] = type;
        _data["status"] = status;
        _data["technician_count"] = technicianCount;
        _data["has_subprojects"] = hasSubprojects;
        _data["planned_hours"] = plannedHours;
        _data["actual_hours"] = actualHours;
        return _data;
    }
}