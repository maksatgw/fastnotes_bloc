import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fastnotes_bloc/features/onboarding/domain/usecases/onboarding_usecase.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final OnboardingUseCase _onboardingUseCase;

  OnboardingCubit(this._onboardingUseCase) : super(OnboardingInitial());

  Future<void> setOnboardingFinished() async {
    final result = await _onboardingUseCase.saveOnboarding();
    result.fold(
      (failure) => emit(OnboardingError(error: failure.message)),
      (success) => emit(OnboardingFinished()),
    );
  }

  Future<void> checkAuth() async {
    final result = await _onboardingUseCase.isAuthenticated();
    result.fold(
      (failure) => emit(OnboardingError(error: failure.message)),
      (success) => emit(
        success ? OnboardingAuthenticated() : OnboardingUnauthenticated(),
      ),
    );
  }

  void onLastPage(int index, int length) {
    if (index == length - 1) {
      emit(OnboardingLastPage());
    } else {
      emit(OnboardingInitial());
    }
  }
}
