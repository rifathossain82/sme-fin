import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static const String _onboardingBoxName = 'onboarding_box';

  /// Initialize Hive
  static Future<void> init() async {
    await Hive.initFlutter();
  }

  /// Get onboarding box
  Future<Box> getOnboardingBox() async {
    if (!Hive.isBoxOpen(_onboardingBoxName)) {
      return await Hive.openBox(_onboardingBoxName);
    }
    return Hive.box(_onboardingBoxName);
  }

  /// Close all boxes
  Future<void> closeAll() async {
    await Hive.close();
  }
}
