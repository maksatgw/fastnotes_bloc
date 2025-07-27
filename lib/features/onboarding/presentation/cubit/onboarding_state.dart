part of 'onboarding_cubit.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

class OnboardingInitial extends OnboardingState {}

class OnboardingLastPage extends OnboardingState {}

class OnboardingFinished extends OnboardingState {}

final class OnboardingAuthenticated extends OnboardingState {}

final class OnboardingUnauthenticated extends OnboardingState {}

class OnboardingError extends OnboardingState {
  final String error;

  const OnboardingError({required this.error});
}
