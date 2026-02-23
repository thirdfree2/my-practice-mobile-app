import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:third_queue_booking_app/bootstrap/app_config.dart';
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

class AppBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // TODO: ส่งเข้า crashlytics/sentry ได้
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap({
  required AppConfig config,
  required Widget Function() builder,
}) async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  Bloc.observer = AppBlocObserver();

  FlutterError.onError = (details) {
    // TODO: report error
  };

  runZonedGuarded(
    () {
      runApp(builder());
    },
    (error, stack) {
      // TODO: report error
    },
  );
}
