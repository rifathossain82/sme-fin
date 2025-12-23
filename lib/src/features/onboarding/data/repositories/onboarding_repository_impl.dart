import 'package:dartz/dartz.dart';
import 'package:sme_fin/src/features/onboarding/data/data_sources/onboarding_local_data_source.dart';
import 'package:sme_fin/src/features/onboarding/data/data_sources/onboarding_remote_data_source.dart';
import 'package:sme_fin/src/features/onboarding/data/models/onboarding_model.dart';
import 'package:sme_fin/src/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:sme_fin/src/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:sme_fin/src/core/core.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingRemoteDataSource remoteDataSource;
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, void>> saveOnboardingData(
    OnboardingEntity data,
  ) async {
    try {
      final model = OnboardingModel.fromEntity(data);
      await localDataSource.saveOnboardingData(model);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, OnboardingEntity?>> getSavedOnboardingData() async {
    try {
      final data = await localDataSource.getSavedOnboardingData();
      return Right(data);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearOnboardingData() async {
    try {
      await localDataSource.clearOnboardingData();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendVerificationCode(String email) async {
    return ApiHelper.safeApiCall(() async {
      return await remoteDataSource.sendVerificationCode(email);
    });
  }

  @override
  Future<Either<Failure, void>> verifyCode(String email, String code) async {
    return ApiHelper.safeApiCall(() async {
      return await remoteDataSource.verifyCode(email, code);
    });
  }

  @override
  Future<Either<Failure, void>> submitOnboardingData(
    OnboardingEntity data,
  ) async {
    return ApiHelper.safeApiCall(() async {
      final model = OnboardingModel.fromEntity(data);
      return await remoteDataSource.submitOnboardingData(model);
    });
  }
}
