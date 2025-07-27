import 'package:bloc/bloc.dart';
import 'package:fastnotes_bloc/features/splash/domain/usecases/splash_usecase.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SplashUseCase _splashUseCase;
  SplashCubit(this._splashUseCase) : super(SplashInitial()) {
    startSplash();
  }

  Future<void> startSplash() async {
    await Future.delayed(const Duration(seconds: 2));
    await checkOnboarding();
    if (state is SplashOnboardingFinished) {
      await checkAuth();
    }
  }

  Future<void> checkAuth() async {
    final result = await _splashUseCase.checkAuth();
    result.fold(
      (failure) => emit(SplashError(message: failure.message)),
      (success) =>
          emit(success ? SplashAuthenticated() : SplashUnauthenticated()),
    );
  }

  Future<void> checkOnboarding() async {
    final result = await _splashUseCase.checkOnboarding();
    result.fold(
      (failure) => emit(SplashError(message: failure.message)),
      (success) => emit(
        success ? SplashOnboardingFinished() : SplashOnboardingNotFinished(),
      ),
    );
  }
}
