import 'package:flutter/widgets.dart';
import 'core/network/api_client.dart';

class AppDependencies extends InheritedWidget {
  final ApiClient apiClient;

  const AppDependencies({
    super.key,
    required this.apiClient,
    required Widget child,
  }) : super(child: child);

  static AppDependencies of(BuildContext context) {
    final deps = context.dependOnInheritedWidgetOfExactType<AppDependencies>();

    assert(deps != null, 'AppDependencies not found in widget tree');
    return deps!;
  }

  @override
  bool updateShouldNotify(covariant AppDependencies oldWidget) {
    // dependency ไม่เปลี่ยนระหว่างรัน
    return false;
  }
}
