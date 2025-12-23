import 'package:sme_fin/src/features/onboarding/data/models/onboarding_model.dart';

abstract class OnboardingRemoteDataSource {
  /// Send verification code
  Future<void> sendVerificationCode(String email);

  /// Verify code
  Future<void> verifyCode(String email, String code);

  /// Submit onboarding data
  Future<void> submitOnboardingData(OnboardingModel data);
}
