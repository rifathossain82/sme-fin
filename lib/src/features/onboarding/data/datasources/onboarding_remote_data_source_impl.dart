import 'dart:math';
import 'package:sme_fin/src/core/core.dart';
import 'package:sme_fin/src/features/onboarding/data/models/onboarding_model.dart';

import 'onboarding_remote_data_source.dart';

class OnboardingRemoteDataSourceImpl implements OnboardingRemoteDataSource {
  final ApiService apiService;
  final Random _random = Random();

  OnboardingRemoteDataSourceImpl(this.apiService);

  /// Simulate network delay
  Future<void> _simulateNetworkDelay() async {
    await Future.delayed(Duration(milliseconds: 1000 + _random.nextInt(1500)));
  }

  /// Simulate random success/failure (80% success rate)
  void _simulateRandomFailure() {
    if (_random.nextInt(100) < 20) {
      throw ServerException('Server error: Request failed');
    }
  }

  @override
  Future<void> sendVerificationCode(String email) async {
    try {
      // Simulate network delay
      await _simulateNetworkDelay();

      // Randomly throw an error to simulate server/network failure
      _simulateRandomFailure();

      // -------------------------------
      // Real API call (future scenario)
      // -------------------------------
      // final response = await sl<ApiService>().post(
      //   ApiEndpoints.sendCode,
      //   data: {
      //     'email': email,
      //   },
      // );
      //

      // Simulate success
      return;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> verifyCode(String email, String code) async {
    try {
      // Simulate network delay
      await _simulateNetworkDelay();

      // Randomly throw an error to simulate server/network failure
      _simulateRandomFailure();

      // -------------------------------
      // Real API call (future scenario)
      // -------------------------------
      // final response = await sl<ApiService>().post(
      //   ApiEndpoints.verifyCode,
      //   data: {
      //     'email': email,
      //     'code': code,
      //   },
      // );
      //

      // Simulate success
      return;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> submitOnboardingData(OnboardingModel data) async {
    try {
      // Simulate network delay
      await _simulateNetworkDelay();

      // Randomly throw an error to simulate server/network failure
      _simulateRandomFailure();

      // -------------------------------
      // Real API call (future scenario)
      // -------------------------------
      // final response = await sl<ApiService>().post(
      //   ApiEndpoints.submitOnboardingData,
      //   data: data.toJson(),
      // );
      //

      // Simulate success
      return;
    } catch (e) {
      rethrow;
    }
  }
}
