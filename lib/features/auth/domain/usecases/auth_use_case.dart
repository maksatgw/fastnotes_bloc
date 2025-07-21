import 'package:fastnotes_bloc/features/auth/domain/entities/auth_entity.dart';
import 'package:fastnotes_bloc/features/auth/domain/repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future<AuthEntity?> login() async {
    return await _authRepository.login();
  }

  Future<AuthEntity?> refreshToken(String refreshToken) async {
    return await _authRepository.refreshToken(refreshToken);
  }

  Future<bool> logOut() async {
    return await _authRepository.logOut();
  }
}
