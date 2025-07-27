import 'package:dartz/dartz.dart';
import 'package:fastnotes_bloc/core/errors/failures.dart';
import 'package:fastnotes_bloc/features/auth/domain/entities/auth_entity.dart';
import 'package:fastnotes_bloc/features/auth/domain/repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future<Either<Failure, AuthEntity>> login() async {
    return await _authRepository.login();
  }

  Future<Either<Failure, AuthEntity>> refreshToken(String refreshToken) async {
    return await _authRepository.refreshToken(refreshToken);
  }

  Future<Either<Failure, void>> logOut() async {
    return await _authRepository.logOut();
  }
}
