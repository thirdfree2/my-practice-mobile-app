class AppConfig {
  final String baseUrl;
  final bool useMock;

  const AppConfig({required this.baseUrl, required this.useMock});

  factory AppConfig.fromEnv() {
    return AppConfig(
      baseUrl: const String.fromEnvironment('BASE_URL', defaultValue: ''),
      useMock: const bool.fromEnvironment('USE_MOCK', defaultValue: false),
    );
  }
}
