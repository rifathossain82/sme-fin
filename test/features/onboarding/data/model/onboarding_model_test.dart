import 'package:flutter_test/flutter_test.dart';
import 'package:sme_fin/src/features/onboarding/data/models/onboarding_model.dart';

import '../../../../fixtures/onboarding_fixtures.dart';

void main() {
  group('OnboardingModel', () {
    group('fromJson', () {
      test('should create OnboardingModel from complete JSON', () {
        // Act
        final result = OnboardingModel.fromJson(OnboardingFixtures.completeJson);

        // Assert
        expect(result.email, equals(OnboardingFixtures.testEmail));
        expect(result.verificationCode, equals(OnboardingFixtures.testVerificationCode));
        expect(result.fullName, equals(OnboardingFixtures.testFullName));
        expect(result.phoneNumber, equals(OnboardingFixtures.testPhoneNumber));
        expect(result.businessName, equals(OnboardingFixtures.testBusinessName));
        expect(result.tradeLicenseNumber, equals(OnboardingFixtures.testTradeLicenseNumber));
        expect(result.tradeLicensePath, equals(OnboardingFixtures.testTradeLicensePath));
        expect(result.isSubmitted, equals(true));
      });

      test('should create OnboardingModel with only required fields', () {
        // Arrange
        final minimalJson = OnboardingFixtures.minimalJson;

        // Act
        final result = OnboardingModel.fromJson(minimalJson);

        // Assert
        expect(result.email, equals(OnboardingFixtures.testEmail));
        expect(result.verificationCode, isNull);
        expect(result.fullName, isNull);
        expect(result.phoneNumber, isNull);
        expect(result.businessName, isNull);
        expect(result.tradeLicenseNumber, isNull);
        expect(result.tradeLicensePath, isNull);
        expect(result.isSubmitted, equals(false));
      });

      test('should handle partial data correctly', () {
        // Act
        final result = OnboardingModel.fromJson(OnboardingFixtures.partialJson);

        // Assert
        expect(result.email, equals(OnboardingFixtures.testEmail));
        expect(result.fullName, equals(OnboardingFixtures.testFullName));
        expect(result.businessName, equals(OnboardingFixtures.testBusinessName));
        expect(result.verificationCode, isNull);
        expect(result.phoneNumber, isNull);
        expect(result.tradeLicenseNumber, isNull);
      });
    });

    group('toJson', () {
      test('should convert OnboardingModel to complete JSON', () {
        // Act
        final result = OnboardingFixtures.completeModel.toJson();

        // Assert
        expect(result, equals(OnboardingFixtures.completeJson));
        expect(result['email'], equals(OnboardingFixtures.testEmail));
        expect(result['verificationCode'], equals(OnboardingFixtures.testVerificationCode));
        expect(result['fullName'], equals(OnboardingFixtures.testFullName));
        expect(result['phoneNumber'], equals(OnboardingFixtures.testPhoneNumber));
        expect(result['businessName'], equals(OnboardingFixtures.testBusinessName));
        expect(result['tradeLicenseNumber'], equals(OnboardingFixtures.testTradeLicenseNumber));
        expect(result['tradeLicensePath'], equals(OnboardingFixtures.testTradeLicensePath));
        expect(result['isSubmitted'], equals(true));
      });

      test('should convert model with null fields to JSON', () {
        // Arrange
        const minimalModel = OnboardingFixtures.minimalModel;

        // Act
        final result = minimalModel.toJson();

        // Assert
        expect(result['email'], equals(OnboardingFixtures.testEmail));
        expect(result['verificationCode'], isNull);
        expect(result['fullName'], isNull);
        expect(result['phoneNumber'], isNull);
        expect(result['businessName'], isNull);
        expect(result['tradeLicenseNumber'], isNull);
        expect(result['tradeLicensePath'], isNull);
        expect(result['isSubmitted'], equals(false));
      });

      test('should include all keys in JSON even if values are null', () {
        // Arrange
        const minimalModel = OnboardingFixtures.minimalModel;

        // Act
        final result = minimalModel.toJson();

        // Assert
        expect(result.containsKey('email'), isTrue);
        expect(result.containsKey('verificationCode'), isTrue);
        expect(result.containsKey('fullName'), isTrue);
        expect(result.containsKey('phoneNumber'), isTrue);
        expect(result.containsKey('businessName'), isTrue);
        expect(result.containsKey('tradeLicenseNumber'), isTrue);
        expect(result.containsKey('tradeLicensePath'), isTrue);
        expect(result.containsKey('isSubmitted'), isTrue);
      });
    });

    group('fromEntity', () {
      test('should create OnboardingModel from OnboardingEntity', () {
        // Arrange
        const entity = OnboardingFixtures.completeEntity;

        // Act
        final result = OnboardingModel.fromEntity(entity);

        // Assert
        expect(result.email, equals(entity.email));
        expect(result.verificationCode, equals(entity.verificationCode));
        expect(result.fullName, equals(entity.fullName));
        expect(result.phoneNumber, equals(entity.phoneNumber));
        expect(result.businessName, equals(entity.businessName));
        expect(result.tradeLicenseNumber, equals(entity.tradeLicenseNumber));
        expect(result.tradeLicensePath, equals(entity.tradeLicensePath));
        expect(result.isSubmitted, equals(entity.isSubmitted));
      });

      test('should handle entity with null fields', () {
        // Arrange
        const entity = OnboardingFixtures.minimalEntity;

        // Act
        final result = OnboardingModel.fromEntity(entity);

        // Assert
        expect(result.email, equals(OnboardingFixtures.testEmail));
        expect(result.verificationCode, isNull);
        expect(result.fullName, isNull);
        expect(result.phoneNumber, isNull);
        expect(result.businessName, isNull);
        expect(result.tradeLicenseNumber, isNull);
        expect(result.tradeLicensePath, isNull);
        expect(result.isSubmitted, equals(false));
      });
    });
  });
}
