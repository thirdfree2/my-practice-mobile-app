// lib/app_dependencies.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:third_queue_booking_app/core/network/api_client.dart';
import 'package:third_queue_booking_app/features/counter/data/datasources/counter_remote_data_source.dart';
import 'package:third_queue_booking_app/features/counter/data/repositories/counter_repository_impl.dart';
import 'package:third_queue_booking_app/features/counter/domain/repositories/counter_repository.dart';

class AppDependencies extends StatelessWidget {
  final Widget child;

  // ใส่ของที่อยากแจกให้ทั้งแอป เช่น apiClient
  final ApiClient apiClient;

  const AppDependencies({
    super.key,
    required this.apiClient,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ApiClient>.value(value: apiClient),

        // ตัวอย่าง: Counter
        RepositoryProvider<CounterRepository>(
          create: (ctx) => CounterRepositoryImpl(
            CounterRemoteDataSource(ctx.read<ApiClient>()),
          ),
        ),

        // ตัวอย่าง: Home (ถ้ามี repo ของมัน)
        // RepositoryProvider<HomeRepository>(create: ...),
      ],
      child: child,
    );
  }
}
