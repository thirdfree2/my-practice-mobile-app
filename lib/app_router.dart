// lib/app_router.dart
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:third_queue_booking_app/features/counter/domain/repositories/counter_repository.dart';

import 'features/home/home.dart';
import 'features/counter/counter.dart';

GoRouter buildRouter() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          // HomeBloc เฉพาะหน้า
          return BlocProvider(
            create: (ctx) {
              final repo = ctx.read<CounterRepository>();
              return HomeBloc(queueRepository: repo, bookingRepository: repo)
                ..add(HomeStarted());
            },
            child: const HomePage(),
          );
        },
      ),
      GoRoute(
        path: '/counter',
        builder: (context, state) {
          // CounterBloc เฉพาะหน้า (แนะนำแบบนี้ถ้าไม่ได้ใช้ทั่วแอป)
          return BlocProvider(
            create: (ctx) => CounterBloc(),
            child: const CounterPage(),
          );
        },
      ),
    ],
  );
}
