import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:third_queue_booking_app/app_router.dart';
import 'package:third_queue_booking_app/core/widgets/nav_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(child: Text("Hello")),
            NavButton(
              label: 'เริ่มจองคิว',
              onPressedAsync: () async {
                // await repo.validate();
                context.pushNamed(RouteNames.splash);
              },
            ),
          ],
        ),
      ),
    );
  }
}
