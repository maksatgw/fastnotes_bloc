import 'package:dio/dio.dart';
import 'package:fastnotes_bloc/core/errors/exceptions.dart';

// Hata yakalama ve işleme fonksiyonu
// DioException'ı ServerException'a dönüştürüyor.
// Bu sayede, hata işleme daha kolay hale getiriyoruz.
// Bu sayede, hata işleme daha kolay hale getiriyoruz.

Exception handleNetworkError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionError:
      return ServerException(message: 'Bağlantı hatası');
    case DioExceptionType.badResponse:
      return ServerException(message: 'Yanıt hatası');
    case DioExceptionType.cancel:
      return ServerException(message: 'İstek iptal edildi');
    case DioExceptionType.connectionTimeout:
      return ServerException(message: 'Bağlantı zaman aşımı');
    default:
      return ServerException(message: 'Beklenmeyen hata');
  }
}
