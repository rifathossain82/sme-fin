import 'package:sme_fin/src/features/onboarding/data/models/onboarding_model.dart';
import 'package:sme_fin/src/features/onboarding/domain/entities/onboarding_entity.dart';

class OnboardingFixtures {
  // Test constants
  static const testStep = OnboardingStep.success;
  static const testEmail = 'test@example.com';
  static const testVerificationCode = '123456';
  static const testFullName = 'John Doe';
  static const testPhoneNumber = '+1234567890';
  static const testBusinessName = 'Test Business';
  static const testTradeLicenseNumber = 'TL123456';
  static const testTradeLicensePath = '/path/to/license.pdf';

  // Complete model
  static const completeModel = OnboardingModel(
    step: OnboardingStep.success,
    email: testEmail,
    verificationCode: testVerificationCode,
    fullName: testFullName,
    phoneNumber: testPhoneNumber,
    businessName: testBusinessName,
    tradeLicenseNumber: testTradeLicenseNumber,
    tradeLicensePath: testTradeLicensePath,
    isSubmitted: true,
  );

  // Minimal model (only required fields)
  static const minimalModel = OnboardingModel(step: OnboardingStep.success, email: testEmail);

  // Partial model (some optional fields)
  static const partialModel = OnboardingModel(
    step: OnboardingStep.success,
    email: testEmail,
    fullName: testFullName,
    businessName: testBusinessName,
  );

  // Complete entity
  static const completeEntity = OnboardingEntity(
    step: OnboardingStep.success,
    email: testEmail,
    verificationCode: testVerificationCode,
    fullName: testFullName,
    phoneNumber: testPhoneNumber,
    businessName: testBusinessName,
    tradeLicenseNumber: testTradeLicenseNumber,
    tradeLicensePath: testTradeLicensePath,
    isSubmitted: true,
  );

  // Minimal entity (only required fields)
  static const minimalEntity = OnboardingEntity(step: OnboardingStep.success, email: testEmail);

  // Complete JSON
  static final completeJson = {
    'step': testStep.name,
    'email': testEmail,
    'verificationCode': testVerificationCode,
    'fullName': testFullName,
    'phoneNumber': testPhoneNumber,
    'businessName': testBusinessName,
    'tradeLicenseNumber': testTradeLicenseNumber,
    'tradeLicensePath': testTradeLicensePath,
    'isSubmitted': true,
  };

  // Minimal JSON
  static final minimalJson = {'email': testEmail};

  // Partial JSON
  static final partialJson = {
    'email': testEmail,
    'fullName': testFullName,
    'businessName': testBusinessName,
  };

  static final completeJsonString =
      '{"email":"$testEmail","fullName":"$testFullName","phoneNumber":"$testPhoneNumber","businessName":"$testBusinessName","tradeLicenseNumber":"$testTradeLicenseNumber"}';
}
