import 'package:dartz/dartz.dart';
import 'package:fastnotes_bloc/core/errors/failures.dart';
import 'package:fastnotes_bloc/features/onboarding/domain/repositories/onboarding_repository.dart';

class OnboardingUseCase {
  final OnboardingRepository _onboardingRepository;

  OnboardingUseCase(this._onboardingRepository);

  Future<Either<Failure, void>> saveOnboarding() async {
    return await _onboardingRepository.saveOnboardingFinished();
  }

  Future<Either<Failure, bool>> isAuthenticated() async {
    return await _onboardingRepository.isAuthenticated();
  }
}
