import 'package:flutter_template/domain/entities/auth.dart';

abstract class AuthsDatasource {
  Future<Auth> login({required String email, required String password});
  Future<void> logout();
  Future<Auth> refresh();
}