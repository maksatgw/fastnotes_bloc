class AuthEntity {
  final String token;
  final String refreshToken;
  final String userId;

  AuthEntity({
    required this.token,
    required this.refreshToken,
    required this.userId,
  });
}
