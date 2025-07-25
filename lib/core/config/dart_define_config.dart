class DartDefineConfig {
  static String get apiUrl {
    final value = const String.fromEnvironment('BASE_URL');
    _validate('BASE_URL', value);
    return value;
  }

  static String get googleServerClientId {
    final value = const String.fromEnvironment('GOOGLE_SERVER_CLIENT_ID');
    _validate('GOOGLE_SERVER_CLIENT_ID', value);
    return value;
  }

  static void _validate(String key, String? value) {
    if (value == null || value.isEmpty) {
      throw Exception('Dart Define Config $key is not set');
    }
  }
}
