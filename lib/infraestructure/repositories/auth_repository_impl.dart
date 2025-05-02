import 'package:flutter_template/domain/entities/auth.dart';
import 'package:flutter_template/domain/datasources/auths_datasource.dart';
import 'package:flutter_template/domain/repositories/auths_repository.dart';

class AuthRepositoryImpl implements AuthsRepository{

  final AuthsDatasource _datasource;

  AuthRepositoryImpl(this._datasource);

  @override
  Future<Auth> login({required String email, required String password}) {
    return _datasource.login(email: email, password: password);
  }
 
  @override
  Future<void> logout() {
    return _datasource.logout();
  }

  @override
  Future<Auth> refresh() {
    return _datasource.refresh();
  }
}