import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sme_fin/src/core/core.dart';
import 'package:sme_fin/src/features/onboarding/domain/use_cases/get_saved_onboarding_data.dart';
import 'package:sme_fin/src/features/onboarding/domain/use_cases/save_onboarding_data.dart';
import 'package:sme_fin/src/features/onboarding/domain/use_cases/submit_onboarding_data.dart';
import 'package:sme_fin/src/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:sme_fin/src/features/onboarding/presentation/bloc/onboarding_event.dart';
import 'package:sme_fin/src/features/onboarding/presentation/bloc/onboarding_state.dart';

import '../../../../fixtures/onboarding_fixtures.dart';
import '../../../../mocks/repositories/mock_onboarding_repository.dart';

void main() {
  late OnboardingBloc bloc;
  late MockOnboardingRepository mockRepository;
  late GetSavedOnboardingData getSavedOnboardingData;
  late SaveOnboardingData saveOnboardingData;
  late SubmitOnboardingData submitOnboardingData;

  setUpAll(() {
    // Register fallback values for mocktail
    registerFallbackValue(OnboardingFixtures.completeEntity);
  });

  setUp(() {
    mockRepository = MockOnboardingRepository();
    getSavedOnboardingData = GetSavedOnboardingData(mockRepository);
    saveOnboardingData = SaveOnboardingData(mockRepository);
    submitOnboardingData = SubmitOnboardingData(mockRepository);
    bloc = OnboardingBloc(
      getSavedOnboardingData: getSavedOnboardingData,
      saveOnboardingData: saveOnboardingData,
      submitOnboardingData: submitOnboardingData,
      repository: mockRepository,
    );
  });

  tearDown(() {
    bloc.close();
  });

  group('OnboardingBloc', () {
    test('initial state should be OnboardingInitial', () {
      expect(bloc.state, equals(OnboardingInitial()));
    });

    group('LoadSavedDataEvent', () {
      blocTest<OnboardingBloc, OnboardingState>(
        'emits [OnboardingLoading, OnboardingDataLoaded] when data exists',
        build: () {
          when(
            () => mockRepository.getSavedOnboardingData(),
          ).thenAnswer((_) async => Right(OnboardingFixtures.completeEntity));
          return bloc;
        },
        act: (bloc) => bloc.add(LoadSavedDataEvent()),
        expect: () => [
          OnboardingLoading(),
          OnboardingDataLoaded(OnboardingFixtures.completeEntity),
        ],
        verify: (_) {
          verify(() => mockRepository.getSavedOnboardingData()).called(1);
        },
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'emits [OnboardingLoading, OnboardingError] when loading fails',
        build: () {
          when(
            () => mockRepository.getSavedOnboardingData(),
          ).thenAnswer((_) async => Left(CacheFailure('Cache error')));
          return bloc;
        },
        act: (bloc) => bloc.add(LoadSavedDataEvent()),
        expect: () => [
          OnboardingLoading(),
          const OnboardingError('Cache error'),
        ],
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'emits [OnboardingLoading, OnboardingDataLoaded] with null when no saved data',
        build: () {
          when(
            () => mockRepository.getSavedOnboardingData(),
          ).thenAnswer((_) async => const Right(null));
          return bloc;
        },
        act: (bloc) => bloc.add(LoadSavedDataEvent()),
        expect: () => [OnboardingLoading(), const OnboardingDataLoaded(null)],
      );
    });

    group('SubmitOnboardingDataEvent', () {
      blocTest<OnboardingBloc, OnboardingState>(
        'emits [OnboardingLoading, OnboardingSubmissionSuccess] when submission succeeds',
        build: () {
          when(
            () => mockRepository.submitOnboardingData(any()),
          ).thenAnswer((_) async => const Right(null));
          return bloc;
        },
        act: (bloc) => bloc.add(
          SubmitOnboardingDataEvent(OnboardingFixtures.completeEntity),
        ),
        expect: () => [OnboardingLoading(), OnboardingSubmissionSuccess()],
        verify: (_) {
          verify(() => mockRepository.submitOnboardingData(any())).called(1);
        },
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'emits [OnboardingLoading, OnboardingError] when submission fails',
        build: () {
          when(
            () => mockRepository.submitOnboardingData(any()),
          ).thenAnswer((_) async => Left(ServerFailure('Server error')));
          return bloc;
        },
        act: (bloc) => bloc.add(
          SubmitOnboardingDataEvent(OnboardingFixtures.completeEntity),
        ),
        expect: () => [
          OnboardingLoading(),
          const OnboardingError('Server error'),
        ],
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'emits [OnboardingLoading, OnboardingError] when network fails',
        build: () {
          when(
            () => mockRepository.submitOnboardingData(any()),
          ).thenAnswer((_) async => Left(NetworkFailure('No internet')));
          return bloc;
        },
        act: (bloc) => bloc.add(
          SubmitOnboardingDataEvent(OnboardingFixtures.completeEntity),
        ),
        expect: () => [
          OnboardingLoading(),
          const OnboardingError('No internet'),
        ],
      );
    });
  });
}
