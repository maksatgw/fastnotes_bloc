import 'package:fastnotes_bloc/core/storage/storage_service.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUserInfo(
    String email,
    String name,
    String photoUrl,
    String token,
    String refreshToken,
    String userId,
  );
  Future<void> clearUserInfo();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final StorageService _storageService;

  AuthLocalDataSourceImpl(this._storageService);

  @override
  Future<void> saveUserInfo(
    String email,
    String name,
    String photoUrl,
    String token,
    String refreshToken,
    String userId,
  ) async {
    await _storageService.setString("UserEmail", email);
    await _storageService.setString("UserName", name);
    await _storageService.setString("UserPhotoUrl", photoUrl);
    await _storageService.setString("token", token);
    await _storageService.setString("refreshToken", refreshToken);
    await _storageService.setString("userId", userId);
  }

  @override
  Future<void> clearUserInfo() async {
    await _storageService.clearAll();
  }
}
