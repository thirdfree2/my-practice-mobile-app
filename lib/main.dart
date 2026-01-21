import 'package:flutter/material.dart';
import 'package:third_queue_booking_app/app_dependencies.dart';
import 'package:third_queue_booking_app/bootstrap/mocks/fake_api_client.dart';
import 'package:third_queue_booking_app/core/network/api_client.dart';
import 'package:third_queue_booking_app/core/network/dio_client.dart';
import 'app.dart';

void main() {
  const useMock = bool.fromEnvironment('USE_MOCK', defaultValue: false);

  final ApiClient apiClient = useMock
      ? FakeApiClient()
      : ApiClient(DioClient(baseUrl: 'Hello').dio);

  runApp(AppDependencies(apiClient: apiClient, child: const MyApp()));
}
