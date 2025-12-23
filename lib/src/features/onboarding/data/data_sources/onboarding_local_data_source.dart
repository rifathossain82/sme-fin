import 'package:sme_fin/src/features/onboarding/data/models/onboarding_model.dart';

abstract class OnboardingLocalDataSource {
  /// Save onboarding data
  Future<void> saveOnboardingData(OnboardingModel data);

  /// Get saved onboarding data
  Future<OnboardingModel?> getSavedOnboardingData();

  /// Clear onboarding data
  Future<void> clearOnboardingData();
}
