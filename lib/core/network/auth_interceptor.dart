import 'package:dio/dio.dart';
import 'package:fastnotes_bloc/core/router/app_router.dart';
import 'package:fastnotes_bloc/core/router/route_names.dart';
import 'package:fastnotes_bloc/core/storage/storage_service.dart';

class AuthInterceptor extends Interceptor {
  final StorageService _storageService;

  AuthInterceptor(this._storageService);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      final token = _storageService.getStringSync("token");
      if (token != null) {
        options.headers["Authorization"] = "Bearer $token";
      }
      handler.next(options);
    } catch (e) {}
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // 401 hatası gelirse, token'ı sil ve login sayfasına yönlendir
      _storageService.clearAll();
      AppRouter.router.go(RouteNames.splash);
    }
    handler.next(err); // Hata zinciri devam etsin
  }
}
