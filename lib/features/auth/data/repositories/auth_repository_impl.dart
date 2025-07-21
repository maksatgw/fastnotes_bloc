import 'package:fastnotes_bloc/core/storage/storage_service.dart';
import 'package:fastnotes_bloc/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:fastnotes_bloc/features/auth/domain/entities/auth_entity.dart';
import 'package:fastnotes_bloc/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final StorageService _storageService;

  AuthRepositoryImpl(this._authRemoteDataSource, this._storageService);

  @override
  Future<void> getLoggedInUser() async {
    final user = await _authRemoteDataSource.getLoggedInUser();
    if (user != null) {
      await _storageService.setString("UserEmail", user.email);
      await _storageService.setString("UserName", user.displayName ?? "");
      await _storageService.setString("UserPhotoUrl", user.photoUrl ?? "");
    }
  }

  @override
  Future<AuthEntity?> login() async {
    final authModel = await _authRemoteDataSource.login();
    if (authModel != null) {
      await _storageService.setString("token", authModel.token);
      await _storageService.setString("refreshToken", authModel.refreshToken);
      await _storageService.setString("userId", authModel.userId);
      await getLoggedInUser();
      return AuthEntity(
        token: authModel.token,
        refreshToken: authModel.refreshToken,
        userId: authModel.userId,
      );
    }
    return null;
  }

  @override
  Future<AuthEntity?> refreshToken(String refreshToken) async {
    final authModel = await _authRemoteDataSource.refreshToken(refreshToken);
    return authModel != null
        ? AuthEntity(
            token: authModel.token,
            refreshToken: authModel.refreshToken,
            userId: authModel.userId,
          )
        : null;
  }

  @override
  Future<bool> logOut() async {
    final isSignedOut = await _authRemoteDataSource.signOut();
    if (isSignedOut) {
      await _storageService.clearAll();
    }
    return isSignedOut;
  }
}
