import 'package:sme_fin/src/features/onboarding/domain/entities/onboarding_entity.dart';

class OnboardingModel extends OnboardingEntity {
  const OnboardingModel({
    required super.step,
    required super.email,
    super.verificationCode,
    super.fullName,
    super.phoneNumber,
    super.businessName,
    super.tradeLicenseNumber,
    super.tradeLicensePath,
    super.isSubmitted,
  });

  factory OnboardingModel.fromJson(Map<String, dynamic> json) {
    return OnboardingModel(
      step: OnboardingStep.values.firstWhere(
        (step) => step.name == json['step'],
        orElse: () => OnboardingStep.signIn,
      ),
      email: json['email'] as String,
      verificationCode: json['verificationCode'] as String?,
      fullName: json['fullName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      businessName: json['businessName'] as String?,
      tradeLicenseNumber: json['tradeLicenseNumber'] as String?,
      tradeLicensePath: json['tradeLicensePath'] as String?,
      isSubmitted: json['isSubmitted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'step': step.name,
      'email': email,
      'verificationCode': verificationCode,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'businessName': businessName,
      'tradeLicenseNumber': tradeLicenseNumber,
      'tradeLicensePath': tradeLicensePath,
      'isSubmitted': isSubmitted,
    };
  }

  factory OnboardingModel.fromEntity(OnboardingEntity entity) {
    return OnboardingModel(
      step: entity.step,
      email: entity.email,
      verificationCode: entity.verificationCode,
      fullName: entity.fullName,
      phoneNumber: entity.phoneNumber,
      businessName: entity.businessName,
      tradeLicenseNumber: entity.tradeLicenseNumber,
      tradeLicensePath: entity.tradeLicensePath,
      isSubmitted: entity.isSubmitted,
    );
  }
}
