// lib/main.dart
import 'package:third_queue_booking_app/bootstrap/mocks/fake_api_client.dart';
import 'package:third_queue_booking_app/core/network/api_client.dart';
import 'package:third_queue_booking_app/core/network/dio_client.dart';

import 'bootstrap/bootstrap.dart';
import 'bootstrap/app_config.dart';
import 'app_dependencies.dart';
import 'app_router.dart';
import 'app.dart';

void main() {
  final config = AppConfig.fromEnv();

  final apiClient = config.useMock
      ? FakeApiClient()
      : ApiClient(DioClient(baseUrl: config.baseUrl).dio);

  final router = buildRouter();

  bootstrap(
    config: config,
    builder: () => AppDependencies(
      apiClient: apiClient,
      child: App(router: router),
    ),
  );
}
