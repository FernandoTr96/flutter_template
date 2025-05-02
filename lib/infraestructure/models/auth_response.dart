import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  
  String accessToken;
  String tokenType;
  int expiresIn;
  int employeeId;
  int profileId;
  String name;
  String email;
  String? role;
  List<String> permissions;
  int companyId;

  AuthModel({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.employeeId,
    required this.profileId,
    required this.name,
    required this.email,
    required this.role,
    required this.permissions,
    required this.companyId,
  });

  AuthModel copyWith({
    String? accessToken,
    String? tokenType,
    int? expiresIn,
    int? employeeId,
    int? profileId,
    String? name,
    String? email,
    dynamic role,
    List<String>? permissions,
    int? companyId,
  }) =>
      AuthModel(
        accessToken: accessToken ?? this.accessToken,
        tokenType: tokenType ?? this.tokenType,
        expiresIn: expiresIn ?? this.expiresIn,
        employeeId: employeeId ?? this.employeeId,
        profileId: profileId ?? this.profileId,
        name: name ?? this.name,
        email: email ?? this.email,
        role: role ?? this.role,
        permissions: permissions ?? this.permissions,
        companyId: companyId ?? this.companyId,
      );

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        employeeId: json["employee_id"] ?? 0,
        profileId: json["profile_id"] ?? 0,
        name: json["name"],
        email: json["email"],
        role: json["role"] ?? 'no-role',
        permissions: List<String>.from(json["permissions"].map((x) => x)),
        companyId: json["company_id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
        "employee_id": employeeId,
        "profile_id": profileId,
        "name": name,
        "email": email,
        "role": role,
        "permissions": List<dynamic>.from(permissions.map((x) => x)),
        "company_id": companyId,
      };
}
