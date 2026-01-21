import 'package:dio/dio.dart';
import 'package:third_queue_booking_app/core/network/api_client.dart';

class FakeApiClient implements ApiClient {
  @override
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));

    if (path == '/counter/today') {
      return {
        'data': {'count': 99},
      };
    }

    return {};
  }
}
