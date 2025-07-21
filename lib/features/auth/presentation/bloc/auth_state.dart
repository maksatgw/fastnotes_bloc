part of 'auth_bloc.dart';

class AuthState {}

final class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthLoggedOut extends AuthState {}

class AuthError extends AuthState {}
