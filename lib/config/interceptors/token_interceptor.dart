import 'package:dio/dio.dart';
import 'package:flutter_template/config/const/index.dart';
import 'package:flutter_template/config/plugins/storage_plugin.dart';

class TokenInterceptor extends Interceptor {

  TokenInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      
      final storage = StoragePlugin();
      final String? refreshToken = await storage.read(Variables.tokenKey);
      final String accessToken = refreshToken ?? '';

      if (accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }

      handler.next(options);

    } catch (e) {
      handler.next(options); 
    }
  }
}
