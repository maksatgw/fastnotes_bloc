import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fastnotes_bloc/core/config/dart_define_config.dart';
import 'package:fastnotes_bloc/core/errors/failures_handler.dart';
import 'package:fastnotes_bloc/core/logging/app_logger.dart';
import 'package:fastnotes_bloc/core/network/auth_interceptor.dart';

// API Çağrıları için singleton kullanılacak generic yapı
// Bu sayede, API çağrıları tek bir instance ile yapılabilir.
// Dio kullanılıyor.
class ApiClient {
  final Dio _dio;
  final AuthInterceptor _authInterceptor;
  final AppLogger _appLogger;

  // Dio'nun baseOptions'u ApiConstants.baseUrl ile oluşturuluyor.
  ApiClient(this._authInterceptor, this._appLogger)
    : _dio = Dio(
        BaseOptions(
          baseUrl: DartDefineConfig.apiUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
        ),
      ) {
    _dio.interceptors.add(_authInterceptor);
  }

  // Get fonksiyonu, path ve queryParameters ile API'ye istek gönderir.
  // Geriye, gerekli dönüşümleri kolaylaştırmak ve kullanılabilir hale getirmek için Map<String, dynamic> dönüyor.
  Future<Map<String, dynamic>?> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      _appLogger.debug('Get request sent to $path');
      final response = await _dio.get(path, queryParameters: queryParameters);
      if (response.statusCode == HttpStatus.ok) {
        _appLogger.debug('Get request successful');
        return response.data as Map<String, dynamic>;
      }
      return null;
    } on DioException catch (e) {
      _appLogger.error('Get request failed', error: e);
      throw handleServerFailure(e);
    }
  }

  // Post fonksiyonu, path ve data ile API'ye istek gönderir.
  // Geriye, gerekli dönüşümleri kolaylaştırmak ve kullanılabilir hale getirmek için Map<String, dynamic> dönüyor.
  Future<Map<String, dynamic>?> post(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    try {
      _appLogger.debug('Post request sent to $path');
      final response = await _dio.post(path, data: data);
      if (response.statusCode == HttpStatus.ok) {
        _appLogger.debug('Post request successful');
        return response.data as Map<String, dynamic>;
      }
      return null;
    } on DioException catch (e) {
      _appLogger.error(
        'Post request failed',
        error: e,
      );
      throw handleServerFailure(e);
    }
  }
}
