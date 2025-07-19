import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fastnotes_bloc/core/constants/api_constants.dart';
import 'package:fastnotes_bloc/core/errors/exception_handler.dart';
import 'package:flutter/foundation.dart';

// API Çağrıları için singleton kullanılacak generic yapı
// Bu sayede, API çağrıları tek bir instance ile yapılabilir.
// Dio kullanılıyor.
class ApiClient {
  final Dio _dio;

  // Dio'nun baseOptions'u ApiConstants.baseUrl ile oluşturuluyor.
  ApiClient() : _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

  // Get fonksiyonu, path ve queryParameters ile API'ye istek gönderir.
  // Geriye, gerekli dönüşümleri kolaylaştırmak ve kullanılabilir hale getirmek için Map<String, dynamic> dönüyor.
  Future<Map<String, dynamic>?> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      if (response.statusCode == HttpStatus.ok) {
        return response.data as Map<String, dynamic>;
      }
      return null;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response?.data);
      }
      throw handleNetworkError(e);
    }
  }
}
