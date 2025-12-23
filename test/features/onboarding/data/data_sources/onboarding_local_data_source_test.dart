import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sme_fin/src/features/onboarding/data/data_sources/onboarding_local_data_source_impl.dart';
import 'package:sme_fin/src/core/core.dart';

import '../../../../fixtures/onboarding_fixtures.dart';
import '../../../../mocks/services/mock_local_storage_service.dart';

void main() {
  late OnboardingLocalDataSourceImpl dataSource;
  late MockLocalStorageService mockStorageService;
  late MockBox mockBox;
  final String boxKey = 'onboarding_data';

  setUp(() {
    mockStorageService = MockLocalStorageService();
    mockBox = MockBox();
    dataSource = OnboardingLocalDataSourceImpl(mockStorageService);
  });

  group('OnboardingLocalDataSource', () {
    group('saveOnboardingData', () {
      test('should save onboarding data to Hive box successfully', () async {
        // Arrange
        when(
          () => mockStorageService.getOnboardingBox(),
        ).thenAnswer((_) async => mockBox);
        when(
          () => mockBox.put(any(), any()),
        ).thenAnswer((_) async => Future.value());

        // Act
        await dataSource.saveOnboardingData(OnboardingFixtures.completeModel);

        // Assert
        verify(() => mockStorageService.getOnboardingBox()).called(1);
        verify(() => mockBox.put(boxKey, any())).called(1);
      });

      test('should throw CacheException when save fails', () async {
        // Arrange
        when(
          () => mockStorageService.getOnboardingBox(),
        ).thenAnswer((_) async => mockBox);
        when(
          () => mockBox.put(any(), any()),
        ).thenThrow(Exception('Save failed'));

        // Act & Assert
        expect(
          () => dataSource.saveOnboardingData(OnboardingFixtures.completeModel),
          throwsA(isA<CacheException>()),
        );
      });
    });

    group('getSavedOnboardingData', () {
      test('should return OnboardingModel when data exists', () async {
        // Arrange
        when(
          () => mockStorageService.getOnboardingBox(),
        ).thenAnswer((_) async => mockBox);
        when(
          () => mockBox.get(boxKey),
        ).thenReturn(OnboardingFixtures.completeJsonString);

        // Act
        final result = await dataSource.getSavedOnboardingData();

        // Assert
        expect(result, isNotNull);
        expect(result?.email, equals(OnboardingFixtures.testEmail));
        expect(result?.fullName, equals(OnboardingFixtures.testFullName));
        verify(() => mockStorageService.getOnboardingBox()).called(1);
        verify(() => mockBox.get(boxKey)).called(1);
      });

      test('should return null when no data exists', () async {
        // Arrange
        when(
          () => mockStorageService.getOnboardingBox(),
        ).thenAnswer((_) async => mockBox);
        when(() => mockBox.get(boxKey)).thenReturn(null);

        // Act
        final result = await dataSource.getSavedOnboardingData();

        // Assert
        expect(result, isNull);
        verify(() => mockBox.get(boxKey)).called(1);
      });

      test('should throw CacheException when retrieval fails', () async {
        // Arrange
        when(
          () => mockStorageService.getOnboardingBox(),
        ).thenAnswer((_) async => mockBox);
        when(() => mockBox.get(any())).thenThrow(Exception('Get failed'));

        // Act & Assert
        expect(
          () => dataSource.getSavedOnboardingData(),
          throwsA(isA<CacheException>()),
        );
      });

      test('should throw CacheException when JSON decode fails', () async {
        // Arrange
        when(
          () => mockStorageService.getOnboardingBox(),
        ).thenAnswer((_) async => mockBox);
        when(() => mockBox.get(boxKey)).thenReturn('invalid json');

        // Act & Assert
        expect(
          () => dataSource.getSavedOnboardingData(),
          throwsA(isA<CacheException>()),
        );
      });
    });

    group('clearOnboardingData', () {
      test('should clear onboarding data from Hive box successfully', () async {
        // Arrange
        when(
          () => mockStorageService.getOnboardingBox(),
        ).thenAnswer((_) async => mockBox);
        when(
          () => mockBox.delete(any()),
        ).thenAnswer((_) async => Future.value());

        // Act
        await dataSource.clearOnboardingData();

        // Assert
        verify(() => mockStorageService.getOnboardingBox()).called(1);
        verify(() => mockBox.delete(boxKey)).called(1);
      });

      test('should throw CacheException when clear fails', () async {
        // Arrange
        when(
          () => mockStorageService.getOnboardingBox(),
        ).thenAnswer((_) async => mockBox);
        when(() => mockBox.delete(any())).thenThrow(Exception('Delete failed'));

        // Act & Assert
        expect(
          () => dataSource.clearOnboardingData(),
          throwsA(isA<CacheException>()),
        );
      });
    });
  });
}
