import 'package:dartz/dartz.dart';
import 'package:sme_fin/src/core/core.dart';
import 'package:sme_fin/src/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:sme_fin/src/features/onboarding/domain/repositories/onboarding_repository.dart';

class GetSavedOnboardingData {
  final OnboardingRepository repository;

  GetSavedOnboardingData(this.repository);

  Future<Either<Failure, OnboardingEntity?>> call() async {
    return await repository.getSavedOnboardingData();
  }
}
