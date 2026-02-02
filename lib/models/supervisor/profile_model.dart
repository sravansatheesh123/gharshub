
class SpvProfileModel {
    bool? success;
    Data? data;

    SpvProfileModel({this.success, this.data});

    SpvProfileModel.fromJson(Map<String, dynamic> json) {
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
    User? user;

    Data({this.user});

    Data.fromJson(Map<String, dynamic> json) {
        user = json["user"] == null ? null : User.fromJson(json["user"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(user != null) {
            _data["user"] = user?.toJson();
        }
        return _data;
    }
}

class User {
    String? id;
    String? employeeId;
    String? name;
    String? username;
    String? role;
    dynamic phone;
    bool? isActive;
    int? salary;
    dynamic foodAllowance;
    dynamic transportationAllowance;
    dynamic accommodationAllowance;
    List<dynamic>? customAllowances;
    String? department;
    bool? hasAccount;
    dynamic projectRoleId;
    String? createdByRole;
    String? createdBy;
    dynamic profileImage;
    String? createdAt;
    String? updatedAt;
    int? v;
    int? totalSalary;

    User({this.id, this.employeeId, this.name, this.username, this.role, this.phone, this.isActive, this.salary, this.foodAllowance, this.transportationAllowance, this.accommodationAllowance, this.customAllowances, this.department, this.hasAccount, this.projectRoleId, this.createdByRole, this.createdBy, this.profileImage, this.createdAt, this.updatedAt, this.v, this.totalSalary});

    User.fromJson(Map<String, dynamic> json) {
        id = json["_id"];
        employeeId = json["employee_id"];
        name = json["name"];
        username = json["username"];
        role = json["role"];
        phone = json["phone"];
        isActive = json["is_active"];
        salary = json["salary"];
        foodAllowance = json["food_allowance"];
        transportationAllowance = json["transportation_allowance"];
        accommodationAllowance = json["accommodation_allowance"];
        customAllowances = json["custom_allowances"] ?? [];
        department = json["department"];
        hasAccount = json["has_account"];
        projectRoleId = json["project_role_id"];
        createdByRole = json["created_by_role"];
        createdBy = json["created_by"];
        profileImage = json["profile_image"];
        createdAt = json["createdAt"];
        updatedAt = json["updatedAt"];
        v = json["__v"];
        totalSalary = json["total_salary"];
        id = json["id"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["_id"] = id;
        _data["employee_id"] = employeeId;
        _data["name"] = name;
        _data["username"] = username;
        _data["role"] = role;
        _data["phone"] = phone;
        _data["is_active"] = isActive;
        _data["salary"] = salary;
        _data["food_allowance"] = foodAllowance;
        _data["transportation_allowance"] = transportationAllowance;
        _data["accommodation_allowance"] = accommodationAllowance;
        if(customAllowances != null) {
            _data["custom_allowances"] = customAllowances;
        }
        _data["department"] = department;
        _data["has_account"] = hasAccount;
        _data["project_role_id"] = projectRoleId;
        _data["created_by_role"] = createdByRole;
        _data["created_by"] = createdBy;
        _data["profile_image"] = profileImage;
        _data["createdAt"] = createdAt;
        _data["updatedAt"] = updatedAt;
        _data["__v"] = v;
        _data["total_salary"] = totalSalary;
        _data["id"] = id;
        return _data;
    }
}