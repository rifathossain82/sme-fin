import 'package:dartz/dartz.dart';
import 'package:sme_fin/src/core/core.dart';
import 'package:sme_fin/src/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:sme_fin/src/features/onboarding/domain/repositories/onboarding_repository.dart';

class SaveOnboardingData {
  final OnboardingRepository repository;

  SaveOnboardingData(this.repository);

  Future<Either<Failure, void>> call(OnboardingEntity data) async {
    return await repository.saveOnboardingData(data);
  }
}
