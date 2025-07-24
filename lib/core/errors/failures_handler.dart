import 'package:dio/dio.dart';
import 'package:fastnotes_bloc/core/errors/failures.dart';

Failure handleServerFailure(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return ConnectionFailure(message: 'Bağlantı zaman aşımı');
    case DioExceptionType.sendTimeout:
      return ConnectionFailure(message: 'Gönderim zaman aşımı');
    case DioExceptionType.receiveTimeout:
      return ConnectionFailure(message: 'Alım zaman aşımı');
    case DioExceptionType.badResponse:
      if (e.response?.statusCode == 401) {
        return UnauthorizedFailure(message: 'Oturum süresi doldu');
      } else if (e.response?.statusCode == 403) {
        return ForbiddenFailure(message: 'Bu işlem için yetkiniz yok');
      } else {
        return ServerFailure(message: 'Yanıt hatası');
      }
    case DioExceptionType.cancel:
      return ConnectionFailure(message: 'İstek iptal edildi');
    case DioExceptionType.badCertificate:
      return ConnectionFailure(message: 'Geçersiz sertifika');
    case DioExceptionType.connectionError:
      return ConnectionFailure(message: 'Bağlantı hatası');
    case DioExceptionType.unknown:
      return ConnectionFailure(message: 'Bilinmeyen hata');
  }
}
