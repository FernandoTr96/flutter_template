import 'package:flutter_template/domain/entities/auth.dart';
import 'package:flutter_template/config/plugins/index.dart';
import 'package:flutter_template/domain/datasources/auth_datasource.dart';
import 'package:flutter_template/infraestructure/mappers/auth_mapper.dart';
import 'package:flutter_template/infraestructure/models/auth_response.dart';

class AuthDatasourceImpl implements AuthDatasource {

  final http = HttpPlugin();

  @override
  Future<Auth> login({required String email, required String password}) async {
    final response = await http.post(path: '/jwt/auth/login', data: {'email': email, 'password':password});
    final model = AuthModel.fromJson(response.data);
    final auth = AuthMapper.toEntity(model);
    return auth;
  }

  @override
  Future<void> logout() async {
    await http.post(path: '/jwt/auth/logout'); 
  }
  
  @override
  Future<Auth> refresh() async {
    final response = await http.post(path: '/jwt/auth/refresh');
    final model = AuthModel.fromJson(response.data);
    final auth = AuthMapper.toEntity(model);
    return auth;
  }  

}