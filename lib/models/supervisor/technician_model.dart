class TechnicianModel {
  final String id;
  final String name;
  final String employeeId;
  final String project;
  final String projectId;

  TechnicianModel({
    required this.id,
    required this.name,
    required this.employeeId,
    required this.project,
    required this.projectId,
  });

  factory TechnicianModel.fromJson(Map<String, dynamic> json) {
    return TechnicianModel(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      employeeId: json["employee_id"] ?? "",
      project: json["project"] ?? "",
      projectId: json["project_id"] ?? "",
    );
  }
}
