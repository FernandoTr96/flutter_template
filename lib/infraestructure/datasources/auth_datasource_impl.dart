import 'package:dio/dio.dart';
import 'package:flutter_template/domain/entities/auth.dart';
import 'package:flutter_template/config/plugins/index.dart';
import 'package:flutter_template/domain/datasources/auth_datasource.dart';
import 'package:flutter_template/infraestructure/errors/auth_errors.dart';
import 'package:flutter_template/infraestructure/errors/custom_error.dart';
import 'package:flutter_template/infraestructure/mappers/auth_mapper.dart';
import 'package:flutter_template/infraestructure/models/auth_response.dart';

class AuthDatasourceImpl implements AuthDatasource {

  final http = HttpPlugin();

  @override
  Future<Auth> login({required String email, required String password}) async {
    try {
      final response = await http.post(path: '/jwt/auth/login', data: {'email': email, 'password':password});
      final model = AuthModel.fromJson(response.data);
      final auth = AuthMapper.toEntity(model);
      return auth;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw WrongCredentials();
      if (e.type == DioExceptionType.unknown) throw WrongCredentials();
      if(e.type == DioExceptionType.connectionTimeout) throw ConnectionTimeout();
      throw CustomError(message: '$e', errorCode: 1);
    } catch (e) {
      throw CustomError(message: '$e', errorCode: 1);
    }
  }

  @override
  Future<void> logout() async {
    await http.post(path: '/jwt/auth/logout'); 
  }
  
  @override
  Future<Auth> refresh() async {
    try {
      final response = await http.post(path: '/jwt/auth/refresh');
      final model = AuthModel.fromJson(response.data);
      final auth = AuthMapper.toEntity(model);
      return auth;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw InvalidToken();
      if (e.type == DioExceptionType.unknown) throw InvalidToken();
      if (e.response?.statusCode == 400) throw NoTokenInRequest();
      throw CustomError(message: '$e', errorCode: 1);
    } catch (e) {
      throw CustomError(message: '$e', errorCode: 1);
    }
  }  

}