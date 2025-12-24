import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sme_fin/src/core/core.dart';
import 'package:sme_fin/src/core/network/network.dart';
import 'package:sme_fin/src/core/services/local_storage_service.dart';
import 'package:sme_fin/src/features/onboarding/data/data_sources/onboarding_local_data_source.dart';
import 'package:sme_fin/src/features/onboarding/data/data_sources/onboarding_local_data_source_impl.dart';
import 'package:sme_fin/src/features/onboarding/data/data_sources/onboarding_remote_data_source.dart';
import 'package:sme_fin/src/features/onboarding/data/data_sources/onboarding_remote_data_source_impl.dart';
import 'package:sme_fin/src/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:sme_fin/src/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:sme_fin/src/features/onboarding/domain/use_cases/get_saved_onboarding_data.dart';
import 'package:sme_fin/src/features/onboarding/domain/use_cases/save_onboarding_data.dart';
import 'package:sme_fin/src/features/onboarding/domain/use_cases/submit_onboarding_data.dart';
import 'package:sme_fin/src/features/onboarding/presentation/bloc/onboarding_bloc.dart';

final sl = GetIt.instance;

/// Initialize dependency injection
Future<void> initializeDependencies() async {
  // Core
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton<ApiClient>(() => ApiClient());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<ApiService>(
    () => ApiService(sl<ApiClient>().dio, sl<NetworkInfo>()),
  );
  sl.registerLazySingleton(() => GlobalKey<ScaffoldMessengerState>());
  sl.registerLazySingleton<NavigationManager>(() => NavigationManager());
  sl.registerLazySingleton(() => LocalStorageService());

  // Data sources
  sl.registerLazySingleton<OnboardingRemoteDataSource>(
    () => OnboardingRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<OnboardingLocalDataSource>(
    () => OnboardingLocalDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<OnboardingRepository>(
    () =>
        OnboardingRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetSavedOnboardingData(sl()));
  sl.registerLazySingleton(() => SaveOnboardingData(sl()));
  sl.registerLazySingleton(() => SubmitOnboardingData(sl()));

  // BLoC
  sl.registerFactory(
    () => OnboardingBloc(
      getSavedOnboardingData: sl(),
      saveOnboardingData: sl(),
      submitOnboardingData: sl(),
      repository: sl(),
    ),
  );
}
