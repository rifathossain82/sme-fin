import 'dart:convert';

import 'package:sme_fin/src/core/services/local_storage_service.dart';
import 'package:sme_fin/src/features/onboarding/data/models/onboarding_model.dart';

import 'package:sme_fin/src/core/core.dart';
import 'onboarding_local_data_source.dart';

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  final LocalStorageService storageService;
  static const String _onboardingKey = 'onboarding_data';

  OnboardingLocalDataSourceImpl(this.storageService);

  @override
  Future<void> saveOnboardingData(OnboardingModel data) async {
    try {
      final box = await storageService.getOnboardingBox();
      await box.put(_onboardingKey, jsonEncode(data.toJson()));
    } catch (e) {
      throw CacheException('Failed to save onboarding data: $e');
    }
  }

  @override
  Future<OnboardingModel?> getSavedOnboardingData() async {
    try {
      final box = await storageService.getOnboardingBox();
      final data = box.get(_onboardingKey);
      if (data == null) return null;
      return OnboardingModel.fromJson(jsonDecode(data));
    } catch (e) {
      throw CacheException('Failed to get onboarding data: $e');
    }
  }

  @override
  Future<void> clearOnboardingData() async {
    try {
      final box = await storageService.getOnboardingBox();
      await box.delete(_onboardingKey);
    } catch (e) {
      throw CacheException('Failed to clear onboarding data: $e');
    }
  }
}
