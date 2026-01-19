class LoginResponseModel {
  final bool success;
  final String token;
  final UserModel user;

  LoginResponseModel({
    required this.success,
    required this.token,
    required this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json["success"] ?? false,
      token: json["data"]?["token"] ?? "",
      user: UserModel.fromJson(json["data"]?["user"] ?? {}),
    );
  }
}

class UserModel {
  final String id;
  final String name;
  final String username;
  final String role;
  final String employeeId;
  final bool isActive;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.role,
    required this.employeeId,
    required this.isActive,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      username: json["username"] ?? "",
      role: json["role"] ?? "",
      employeeId: json["employee_id"] ?? "",
      isActive: json["is_active"] ?? false,
    );
  }
}
