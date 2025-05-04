import 'package:flutter_template/domain/entities/auth.dart';

abstract class AuthRepository {
  Future<Auth> login({required String email, required String password});
  Future<void> logout();
  Future<Auth> refresh();
}
