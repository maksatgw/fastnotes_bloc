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
    emit(AuthLoading());
    final authEntity = await _authUseCase.login();
    authEntity.fold(
      (failure) => emit(AuthError()),
      (success) => emit(AuthSuccess()),
    );
  }

  Future<void> _onLogoutEvent(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final isLoggedOut = await _authUseCase.logOut();
    isLoggedOut.fold(
      (failure) => emit(AuthError()),
      (success) => emit(AuthLoggedOut()),
    );
  }
}
