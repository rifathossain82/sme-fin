import 'package:equatable/equatable.dart';
import 'package:sme_fin/src/features/onboarding/domain/entities/onboarding_entity.dart';

/// Events for onboarding BLoC
abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load saved data
class LoadSavedDataEvent extends OnboardingEvent {}

/// Event to send verification code
class SendVerificationCodeEvent extends OnboardingEvent {
  final String email;

  const SendVerificationCodeEvent(this.email);

  @override
  List<Object?> get props => [email];
}

/// Event to verify code
class VerifyCodeEvent extends OnboardingEvent {
  final String email;
  final String code;

  const VerifyCodeEvent(this.email, this.code);

  @override
  List<Object?> get props => [email, code];
}

/// Event to update onboarding data
class UpdateOnboardingDataEvent extends OnboardingEvent {
  final OnboardingEntity data;

  const UpdateOnboardingDataEvent(this.data);

  @override
  List<Object?> get props => [data];
}

/// Event to submit onboarding data
class SubmitOnboardingDataEvent extends OnboardingEvent {
  final OnboardingEntity data;

  const SubmitOnboardingDataEvent(this.data);

  @override
  List<Object?> get props => [data];
}

/// Event to clear data
class ClearOnboardingDataEvent extends OnboardingEvent {}
