import 'package:flutter_template/domain/entities/auth.dart';
import 'package:flutter_template/infraestructure/models/auth_response.dart';

class AuthMapper {
  static Auth toEntity(AuthModel model) => Auth(
    profileId: model.profileId, 
    companyId: model.companyId,
    employeeId: model.employeeId,
    name: model.name, 
    email: model.email, 
    role: model.role, 
    permissions: model.permissions, 
    token: model.accessToken
  );
}