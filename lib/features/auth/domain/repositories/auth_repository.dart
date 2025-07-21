import 'package:fastnotes_bloc/features/auth/domain/entities/auth_entity.dart';

abstract class AuthRepository {
  Future<AuthEntity?> login();
  Future<AuthEntity?> refreshToken(String refreshToken);
  Future<void> getLoggedInUser();
  Future<bool> logOut();
}
