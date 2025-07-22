import 'package:bloc/bloc.dart';
import 'package:fastnotes_bloc/core/models/user_model.dart';
import 'package:fastnotes_bloc/core/usecases/get_logged_user_use_case.dart';

part 'logged_user_state.dart';

class LoggedUserCubit extends Cubit<LoggedUserState> {
  final GetLoggedUserUseCase _getLoggedUserUseCase;
  LoggedUserCubit(this._getLoggedUserUseCase) : super(UserLoading());

  Future<void> getLoggedUser() async {
    final user = await _getLoggedUserUseCase.getLoggedUser();
    user.fold(
      (failure) => emit(UserError(message: failure.message)),
      (success) => emit(UserLoaded(user: success)),
    );
  }
}
