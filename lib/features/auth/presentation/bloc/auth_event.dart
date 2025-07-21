part of 'auth_bloc.dart';

sealed class AuthEvent {}

class LoginEvent extends AuthEvent {}

class RefreshTokenEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}
