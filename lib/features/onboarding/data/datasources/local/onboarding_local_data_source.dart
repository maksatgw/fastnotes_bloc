import 'package:fastnotes_bloc/core/storage/storage_service.dart';

abstract class OnboardingLocalDataSource {
  Future<void> saveOnboardingFinished();
  Future<bool> isOnboardingFinished();
  Future<bool> isAuthenticated();
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  final StorageService _storageService;

  OnboardingLocalDataSourceImpl(this._storageService);

  @override
  Future<bool> isOnboardingFinished() async {
    return await _storageService.getBool("isOnboardingFinished");
  }

  @override
  Future<void> saveOnboardingFinished() async {
    await _storageService.setBool("isOnboardingFinished", true);
  }

  @override
  Future<bool> isAuthenticated() async {
    return await _storageService.getBool("token");
  }
}
