import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sme_fin/src/core/services/local_storage_service.dart';

class MockLocalStorageService extends Mock implements LocalStorageService {}

class MockBox extends Mock implements Box<dynamic> {}
