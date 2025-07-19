// Core katmanı için exceptionlar
// Ağırlıklı olarak network, DI Container ve diğer katmanlar için kullanılıyor.

// Sunucu Hatası
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({required this.message, this.statusCode});
}
