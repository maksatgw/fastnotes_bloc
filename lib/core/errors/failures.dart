import 'package:equatable/equatable.dart';

// Tüm hata tipleri için temel sınıf
abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];

  @override
  String toString() => message;
}

// Sunucu kaynaklı hatalar
class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.statusCode});
}

// Cache kaynaklı hatalar
class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

// Beklenmeyen hatalar
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({required super.message});
}

// İnternet bağlantı hataları
class ConnectionFailure extends Failure {
  const ConnectionFailure({required super.message});
}

class ValidationFailure extends Failure {
  const ValidationFailure({required super.message});
}
