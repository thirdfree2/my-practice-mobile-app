import 'package:third_queue_booking_app/bootstrap/env.dart';
import 'package:third_queue_booking_app/bootstrap/mocks/fake_api_client.dart';

import '../core/network/dio_client.dart';
import '../core/network/api_client.dart';

ApiClient createApiClient({bool mock = false}) {
  if (mock) {
    return FakeApiClient();
  }

  final dioClient = DioClient(baseUrl: Env.apiBaseUrl);

  return ApiClient(dioClient.dio);
}
