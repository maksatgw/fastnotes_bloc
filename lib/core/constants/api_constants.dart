// API için sabitler
class ApiConstants {
  static const String apiUrl = String.fromEnvironment('BASE_URL');
  static const String googleServerClientId = String.fromEnvironment(
    'GOOGLE_SERVER_CLIENT_ID',
  );
  static const String notes = '/api/notes';

  static const String login = '/api/auth/google';
  static const String refreshToken = '/api/auth/refresh-token';
}
