import 'package:equatable/equatable.dart';

enum OnboardingStep {
  signIn,
  verification,
  personalDetails,
  businessDetails,
  uploadLicense,
  confirmation,
  success,
}

class OnboardingEntity extends Equatable {
  final OnboardingStep step;
  final String email;
  final String? verificationCode;
  final String? fullName;
  final String? phoneNumber;
  final String? businessName;
  final String? tradeLicenseNumber;
  final String? tradeLicensePath;
  final bool isSubmitted;

  const OnboardingEntity({
    required this.step,
    required this.email,
    this.verificationCode,
    this.fullName,
    this.phoneNumber,
    this.businessName,
    this.tradeLicenseNumber,
    this.tradeLicensePath,
    this.isSubmitted = false,
  });

  OnboardingEntity copyWith({
    OnboardingStep? step,
    String? email,
    String? verificationCode,
    String? fullName,
    String? phoneNumber,
    String? businessName,
    String? tradeLicenseNumber,
    String? tradeLicensePath,
    bool? isSubmitted,
  }) {
    return OnboardingEntity(
      step: step ?? this.step,
      email: email ?? this.email,
      verificationCode: verificationCode ?? this.verificationCode,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      businessName: businessName ?? this.businessName,
      tradeLicenseNumber: tradeLicenseNumber ?? this.tradeLicenseNumber,
      tradeLicensePath: tradeLicensePath ?? this.tradeLicensePath,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }

  @override
  List<Object?> get props => [
    step,
    email,
    verificationCode,
    fullName,
    phoneNumber,
    businessName,
    tradeLicenseNumber,
    tradeLicensePath,
    isSubmitted,
  ];
}
