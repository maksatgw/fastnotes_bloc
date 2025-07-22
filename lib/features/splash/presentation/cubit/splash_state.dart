part of 'splash_cubit.dart';

sealed class SplashState {}

final class SplashInitial extends SplashState {}

final class SplashAnimating extends SplashState {}

final class SplashAuthenticated extends SplashState {}

final class SplashUnauthenticated extends SplashState {}

final class SplashError extends SplashState {
  final String message;

  SplashError({required this.message});
}
