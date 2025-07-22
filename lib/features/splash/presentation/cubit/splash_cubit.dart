import 'package:bloc/bloc.dart';
import 'package:fastnotes_bloc/features/splash/domain/usecases/splash_use_case.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SplashUseCase _splashUseCase;
  SplashCubit(this._splashUseCase) : super(SplashInitial()) {
    startSplash();
  }

  Future<void> startSplash() async {
    emit(SplashAnimating());
    await Future.delayed(const Duration(seconds: 5));
    await checkAuth();
  }

  Future<void> checkAuth() async {
    final result = await _splashUseCase.checkAuth();
    result.fold(
      (failure) => emit(SplashError(message: failure.message)),
      (success) =>
          emit(success ? SplashAuthenticated() : SplashUnauthenticated()),
    );
  }
}
