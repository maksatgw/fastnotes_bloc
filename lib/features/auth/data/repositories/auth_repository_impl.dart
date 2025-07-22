import 'package:dartz/dartz.dart';
import 'package:fastnotes_bloc/core/errors/failures.dart';
import 'package:fastnotes_bloc/features/auth/data/datasources/local/auth_local_data_source.dart';
import 'package:fastnotes_bloc/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:fastnotes_bloc/features/auth/domain/entities/auth_entity.dart';
import 'package:fastnotes_bloc/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  AuthRepositoryImpl(
    this._authRemoteDataSource,
    this._authLocalDataSource,
  );

  @override
  Future<Either<Failure, AuthEntity>> login() async {
    try {
      final authModel = await _authRemoteDataSource.login();
      if (authModel != null) {
        var user = await _authRemoteDataSource.getLoggedInUser();
        if (user != null) {
          await _authLocalDataSource.saveUserInfo(
            user.email,
            user.displayName ?? "",
            user.photoUrl ?? "",
            authModel.token,
            authModel.refreshToken,
            authModel.userId,
          );
        }
        return Right(
          AuthEntity(
            token: authModel.token,
            refreshToken: authModel.refreshToken,
            userId: authModel.userId,
          ),
        );
      }
      return Left(ServerFailure(message: ""));
    } on ServerFailure catch (e) {
      return Left(e);
    } on CacheFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> refreshToken(String refreshToken) async {
    try {
      final authModel = await _authRemoteDataSource.refreshToken(refreshToken);
      if (authModel != null) {
        return Right(
          AuthEntity(
            token: authModel.token,
            refreshToken: authModel.refreshToken,
            userId: authModel.userId,
          ),
        );
      }
      return Left(ServerFailure(message: ""));
    } on ServerFailure catch (e) {
      return Left(e);
    } on CacheFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      final isSignedOut = await _authRemoteDataSource.signOut();
      if (isSignedOut) {
        await _authLocalDataSource.clearUserInfo();
      }
      return Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } on CacheFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
