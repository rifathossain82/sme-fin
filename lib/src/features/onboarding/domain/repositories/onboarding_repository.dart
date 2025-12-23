import 'package:dartz/dartz.dart';
import 'package:sme_fin/src/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:sme_fin/src/core/core.dart';

abstract class OnboardingRepository {
  /// Save onboarding data locally
  Future<Either<Failure, void>> saveOnboardingData(OnboardingEntity data);

  /// Get saved onboarding data
  Future<Either<Failure, OnboardingEntity?>> getSavedOnboardingData();

  /// Submit onboarding data to server
  Future<Either<Failure, void>> submitOnboardingData(OnboardingEntity data);

  /// Send verification code
  Future<Either<Failure, void>> sendVerificationCode(String email);

  /// Verify code
  Future<Either<Failure, void>> verifyCode(String email, String code);

  /// Clear saved data
  Future<Either<Failure, void>> clearOnboardingData();
}
