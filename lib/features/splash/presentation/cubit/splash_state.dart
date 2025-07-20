part of 'splash_cubit.dart';

sealed class SplashState {}

final class SplashInitial extends SplashState {}

final class SplashAnimating extends SplashState {}

final class SplashCompleted extends SplashState {}
