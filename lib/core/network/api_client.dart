import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final res = await _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );

    final data = res.data;

    if (data is Map<String, dynamic>) {
      return data;
    }

    throw DioException(
      requestOptions: res.requestOptions,
      response: res,
      type: DioExceptionType.badResponse,
      error: 'Expected JSON object but got: ${data.runtimeType}',
    );
  }
}
