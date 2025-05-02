class Auth {

  final int profileId;
  final int employeeId;
  final int companyId;
  final String name;
  final String email;
  final String? role;
  final List<String> permissions;
  final String token;

  Auth({
    required this.profileId,
    required this.employeeId,
    required this.companyId,
    required this.name,
    required this.email,
    required this.role,
    required this.permissions,
    required this.token
  });

}
