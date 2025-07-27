import 'package:dio/dio.dart';
import 'package:fastnotes_bloc/core/logging/app_logger.dart';
import 'package:fastnotes_bloc/core/router/app_router.dart';
import 'package:fastnotes_bloc/core/router/route_names.dart';
import 'package:fastnotes_bloc/core/storage/storage_service.dart';
import 'package:fastnotes_bloc/core/utils/user_storage_utils.dart';

class AuthInterceptor extends Interceptor {
  final StorageService _storageService;
  final AppLogger _appLogger;
  AuthInterceptor(this._storageService, this._appLogger);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      final token = _storageService.getStringSync("token");
      if (token != null) {
        options.headers["Authorization"] = "Bearer $token";
      }
      handler.next(options);
    } catch (e) {
      _appLogger.error('Error in onRequest', error: e);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      _appLogger.error('401 error', error: err);
      // 401 hatası gelirse, token'ı sil ve login sayfasına yönlendir
      clearUserData(_storageService);
      AppRouter.router.go(RouteNames.splash);
    }
    _appLogger.error('Error in onError', error: err);
    handler.next(err); // Hata zinciri devam etsin
  }
}
