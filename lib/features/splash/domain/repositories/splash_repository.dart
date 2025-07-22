import 'package:dartz/dartz.dart';
import 'package:fastnotes_bloc/core/errors/failures.dart';

abstract class SplashRepository {
  Future<Either<Failure, bool>> checkAuth();
}
