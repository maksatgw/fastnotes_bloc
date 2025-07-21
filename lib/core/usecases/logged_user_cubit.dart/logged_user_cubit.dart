import 'package:bloc/bloc.dart';
import 'package:fastnotes_bloc/core/models/user_model.dart';
import 'package:fastnotes_bloc/core/usecases/get_logged_user_use_case.dart';

class LoggedUserCubit extends Cubit<UserModel?> {
  final GetLoggedUserUseCase _getLoggedUserUseCase;
  LoggedUserCubit(this._getLoggedUserUseCase) : super(null);

  Future<void> getLoggedUser() async {
    final user = await _getLoggedUserUseCase.getLoggedUser();
    emit(user);
  }
}
