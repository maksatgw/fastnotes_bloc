import 'package:fastnotes_bloc/core/storage/storage_service.dart';

abstract class SplashLocalDataSource {
  Future<bool> checkAuth();
  Future<bool> checkOnboarding();
}

class SplashLocalDataSourceImpl implements SplashLocalDataSource {
  final StorageService _storageService;

  SplashLocalDataSourceImpl(this._storageService);

  @override
  Future<bool> checkAuth() async {
    final token = await _storageService.getString("token");
    if (token == null) {
      return false;
    }
    return true;
  }

  @override
  Future<bool> checkOnboarding() async {
    return await _storageService.getBool("isOnboardingFinished");
  }
}
