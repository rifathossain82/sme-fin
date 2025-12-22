import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sme_fin/src/core/network/network.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();

  factory ApiClient() => _instance;

  late final Dio dio;

  ApiClient._internal() {
    final baseOptions = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: Duration(milliseconds: ApiConstants.connectionTimeout),
      receiveTimeout: Duration(seconds: ApiConstants.receiveTimeout),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    /// Set sendTimeout when platform is not web
    if (!kIsWeb) {
      baseOptions.sendTimeout = const Duration(seconds: 10);
    }

    dio = Dio(baseOptions);

    _setupInterceptors();
  }

  void _setupInterceptors() {
    dio.interceptors.addAll([
      NetworkRetryInterceptor(dio: dio),
      NetworkLoggerInterceptor(),
      ErrorInterceptor(),
    ]);
  }
}
