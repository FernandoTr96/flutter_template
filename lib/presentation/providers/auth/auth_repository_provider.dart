import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/infraestructure/datasources/auth_datasource_impl.dart';
import 'package:flutter_template/infraestructure/repositories/auth_repository_impl.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepositoryImpl(AuthDatasourceImpl());
});