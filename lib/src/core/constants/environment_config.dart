class EnvironmentConfig {
  EnvironmentConfig._();
  static const baseUrl = String.fromEnvironment("API_BASE_URL");
  static const apiKey = String.fromEnvironment("API_ID_KEY");
}
