import 'package:equatable/equatable.dart';

class OnboardingEntity extends Equatable {
  final String email;
  final String? verificationCode;
  final String? fullName;
  final String? phoneNumber;
  final String? businessName;
  final String? tradeLicenseNumber;
  final String? tradeLicensePath;
  final bool isSubmitted;

  const OnboardingEntity({
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
