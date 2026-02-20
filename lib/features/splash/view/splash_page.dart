import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../core/core.dart';
// ถ้าใช้ flutter_native_splash:
// import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Future.delayed(const Duration(milliseconds: 5000));

    // ถ้าใช้ flutter_native_splash ให้ remove หลัง init:
    // FlutterNativeSplash.remove();

    // if (mounted) context.go('/'); // ไปหน้า Home
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.light().primaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hello",
                style: AppTypography.h2(
                  context,
                ).copyWith(color: context.colors.primaryFixedDim),
              ),
              Lottie.asset(
                'assets/lottie/loader-cat.json',
                width: 500,
                repeat: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
