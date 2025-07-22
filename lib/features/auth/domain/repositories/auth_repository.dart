import 'package:dartz/dartz.dart';
import 'package:fastnotes_bloc/core/errors/failures.dart';
import 'package:fastnotes_bloc/features/auth/domain/entities/auth_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> login();
  Future<Either<Failure, AuthEntity>> refreshToken(String refreshToken);
  Future<Either<Failure, void>> logOut();
}
