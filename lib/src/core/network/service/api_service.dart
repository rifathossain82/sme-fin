import 'package:dio/dio.dart';
import 'package:sme_fin/src/core/core.dart';

class ApiService {
  final Dio _dio;
  final NetworkInfo _networkInfo;

  ApiService(this._dio, this._networkInfo);

  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    if (!await _networkInfo.isConnected) {
      throw NetworkException();
    }

    try {
      return await _dio.get(endpoint, queryParameters: queryParameters);
    } on DioException {
      rethrow;
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  Future<Response> post(String endpoint, {dynamic data}) async {
    if (!await _networkInfo.isConnected) {
      throw NetworkException();
    }

    try {
      return await _dio.post(endpoint, data: data);
    } on DioException {
      rethrow;
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  Future<Response> put(String endpoint, {dynamic data}) async {
    if (!await _networkInfo.isConnected) {
      throw NetworkException();
    }

    try {
      return await _dio.put(endpoint, data: data);
    } on DioException {
      rethrow;
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  Future<Response> delete(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    if (!await _networkInfo.isConnected) {
      throw NetworkException();
    }

    try {
      return await _dio.delete(endpoint, queryParameters: queryParameters);
    } on DioException {
      rethrow;
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
