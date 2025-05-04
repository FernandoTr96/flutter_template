import 'package:dio/dio.dart';
import 'package:flutter_template/config/router/app_router.dart';
import 'package:flutter_template/presentation/screens/index.dart';
import 'package:flutter_template/presentation/providers/index.dart';

class ErrorInterceptor extends Interceptor {
  
  ErrorInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    
    final router = containerProvider.read(appRouter);
    
    if (err.response?.statusCode == 401) {
      router.pushNamed(LoginScreen.name);
    }

    return handler.next(err);
  }
}