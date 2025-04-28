import 'package:dio/dio.dart';
import 'package:flutter_template/config/const/index.dart';
import 'package:flutter_template/config/interceptors/index.dart';

class HttpPlugin {

  final Dio _dio;

  HttpPlugin({BaseOptions? options})
      : _dio = Dio(options ?? _defaultOptions) {
    _setupInterceptors();
  }

  static final BaseOptions _defaultOptions = BaseOptions(
    baseUrl: Env.api,
    responseType: ResponseType.json,
    contentType: 'application/json',
  );

  void _setupInterceptors() {
    _dio.interceptors.addAll([TokenInterceptor()]);
  }

  Future<Response<T>> _sendRequest<T>(
    String path, {
    required String method,
    Map<String, dynamic> data = const {},
    Map<String, dynamic> queryParams = const {},
    bool isFormData = false,
  }) async {
    
    final options = Options(
      contentType: isFormData ? 'multipart/form-data' : null,
    );
    
    final body = isFormData ? _toFormData(data) : data;

    try {
      switch (method) {
        case 'POST':
          return await _dio.post(path, data: body, options: options);
        case 'PUT':
          return await _dio.put(path, data: body, options: options);
        case 'PATCH':
          return await _dio.patch(path, data: body, options: options);
        case 'DELETE':
          return await _dio.delete(path, options: options);
        case 'GET':
        default:
          return await _dio.get(path, queryParameters: queryParams, options: options);
      }
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: path),
        error: "Request failed: $e",
        type: DioExceptionType.unknown,
      );
    }
  }

  Future<Response<T>> get<T>({
    required String path,
    Map<String, dynamic> queryParams = const {},
  }) {
    return _sendRequest<T>(path, method: 'GET', queryParams: queryParams);
  }

  Future<Response<T>> post<T>({
    required String path,
    Map<String, dynamic> data = const {},
    bool isFormData = false,
  }) {
    return _sendRequest<T>(path, method: 'POST', data: data, isFormData: isFormData);
  }

  Future<Response<T>> put<T>({
    required String path,
    Map<String, dynamic> data = const {},
    bool isFormData = false,
  }) {
    return _sendRequest<T>(path, method: 'PUT', data: data, isFormData: isFormData);
  }

  Future<Response<T>> delete<T>({
    required String path,
  }) {
    return _sendRequest<T>(path, method: 'DELETE');
  }

  Future<Response<T>> patch<T>({
    required String path,
    Map<String, dynamic> data = const {},
    bool isFormData = false,
  }) {
    return _sendRequest<T>(path, method: 'PATCH', data: data, isFormData: isFormData);
  }

  Future<List<dynamic>> multiple<T>(List<Future> requests) {
    return Future.wait(requests);
  }

  FormData _toFormData(Map<String, dynamic> data) {
    return FormData.fromMap(data);
  }

  Future<MultipartFile> toMultipartFile(String path) async {
    return MultipartFile.fromFile(path, filename: path.split('/').last);
  }

  Dio get instance => _dio;

  Dio get cleanInstance => Dio();
}
