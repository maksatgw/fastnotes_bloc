import 'package:bloc/bloc.dart';
import 'package:fastnotes_bloc/core/storage/storage_service.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final StorageService _storageService;
  SplashCubit(this._storageService) : super(SplashInitial()) {
    startSplash();
  }

  Future<void> startSplash() async {
    emit(SplashAnimating());
    await Future.delayed(const Duration(seconds: 5));
    await checkAuth();
  }

  Future<void> checkAuth() async {
    final token = await _storageService.getString("token");
    if (token != null) {
      emit(SplashAuthenticated());
    } else {
      emit(SplashUnauthenticated());
    }
  }
}
