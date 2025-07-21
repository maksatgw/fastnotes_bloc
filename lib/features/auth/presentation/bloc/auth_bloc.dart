import 'package:bloc/bloc.dart';
import 'package:fastnotes_bloc/features/auth/domain/usecases/auth_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase _authUseCase;
  AuthBloc(this._authUseCase) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<LogoutEvent>(_onLogoutEvent);
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final authEntity = await _authUseCase.login();
      if (authEntity != null) {
        emit(AuthSuccess());
      }
    } catch (e) {
      emit(AuthError());
    }
  }

  Future<void> _onLogoutEvent(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      final isLoggedOut = await _authUseCase.logOut();
      if (isLoggedOut) {
        emit(AuthLoggedOut());
      }
    } catch (e) {
      emit(AuthError());
    }
  }
}
