// lib/app_router.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:third_queue_booking_app/features/counter/domain/repositories/counter_repository.dart';

import 'features/counter/counter.dart';
import 'features/home/home.dart';
import 'features/splash/splash.dart';

class RouteNames {
  static const splash = 'splash';
  static const home = 'home';
  static const counter = 'counter';
}

GoRouter buildRouter() {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: RouteNames.splash,
        builder: (_, __) => const SplashPage(),
      ),
      GoRoute(
        path: '/',
        name: RouteNames.home,
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
        name: RouteNames.counter,
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
