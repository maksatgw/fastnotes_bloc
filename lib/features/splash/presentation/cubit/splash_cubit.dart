import 'package:bloc/bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()) {
    startSplash();
  }

  Future<void> startSplash() async {
    emit(SplashAnimating());
    await Future.delayed(const Duration(seconds: 5));
    emit(SplashCompleted());
  }
}
