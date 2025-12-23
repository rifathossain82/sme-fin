import 'package:equatable/equatable.dart';
import 'package:sme_fin/src/features/onboarding/domain/entities/onboarding_entity.dart';

/// States for onboarding BLoC
abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class OnboardingInitial extends OnboardingState {}

/// Loading state
class OnboardingLoading extends OnboardingState {}

/// Data loaded state
class OnboardingDataLoaded extends OnboardingState {
  final OnboardingEntity? data;

  const OnboardingDataLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

/// Verification code sent state
class VerificationCodeSent extends OnboardingState {
  final String email;

  const VerificationCodeSent(this.email);

  @override
  List<Object?> get props => [email];
}

/// Code verified state
class CodeVerified extends OnboardingState {
  final String email;

  const CodeVerified(this.email);

  @override
  List<Object?> get props => [email];
}

/// Data saved state
class OnboardingDataSaved extends OnboardingState {
  final OnboardingEntity data;

  const OnboardingDataSaved(this.data);

  @override
  List<Object?> get props => [data];
}

/// Submission success state
class OnboardingSubmissionSuccess extends OnboardingState {}

/// Error state
class OnboardingError extends OnboardingState {
  final String message;

  const OnboardingError(this.message);

  @override
  List<Object?> get props => [message];
}
