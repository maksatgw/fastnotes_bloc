import 'package:dartz/dartz.dart';
import 'package:fastnotes_bloc/core/errors/failures.dart';
import 'package:fastnotes_bloc/features/onboarding/data/datasources/local/onboarding_local_data_source.dart';
import 'package:fastnotes_bloc/features/onboarding/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource _onboardingLocalDataSource;

  OnboardingRepositoryImpl(this._onboardingLocalDataSource);

  @override
  Future<Either<Failure, bool>> isOnboardingFinished() async {
    try {
      final isFinished = await _onboardingLocalDataSource
          .isOnboardingFinished();
      return Right(isFinished);
    } on CacheFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveOnboardingFinished() async {
    try {
      await _onboardingLocalDataSource.saveOnboardingFinished();
      return Right(null);
    } on CacheFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final isAuthenticated = await _onboardingLocalDataSource
          .isAuthenticated();
      return Right(isAuthenticated);
    } on CacheFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
