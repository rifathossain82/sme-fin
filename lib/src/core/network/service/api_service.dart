import 'package:dio/dio.dart';
import 'package:sme_fin/src/core/errors/app_exception.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(endpoint, queryParameters: queryParameters);
    } on DioException {
      rethrow;
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  Future<Response> post(String endpoint, {dynamic data}) async {
    try {
      return await _dio.post(endpoint, data: data);
    } on DioException {
      rethrow;
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  Future<Response> put(String endpoint, {dynamic data}) async {
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
    try {
      return await _dio.delete(endpoint, queryParameters: queryParameters);
    } on DioException {
      rethrow;
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
