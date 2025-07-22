part of 'logged_user_cubit.dart';

sealed class LoggedUserState {}

final class UserLoading extends LoggedUserState {}

class UserLoaded extends LoggedUserState {
  final UserModel user;
  UserLoaded({required this.user});
}

class UserError extends LoggedUserState {
  final String message;
  UserError({required this.message});
}
