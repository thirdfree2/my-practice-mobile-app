import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient._(this.dio);

  factory DioClient({required String baseUrl, String? token}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // ===== Interceptors =====
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          // global error handling
          return handler.next(error);
        },
      ),
    );

    return DioClient._(dio);
  }
}
