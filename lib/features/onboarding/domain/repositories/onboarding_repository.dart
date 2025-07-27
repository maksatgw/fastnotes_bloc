import 'package:dartz/dartz.dart';
import 'package:fastnotes_bloc/core/errors/failures.dart';

abstract class OnboardingRepository {
  Future<Either<Failure, void>> saveOnboardingFinished();
  Future<Either<Failure, bool>> isOnboardingFinished();
  Future<Either<Failure, bool>> isAuthenticated();
}
