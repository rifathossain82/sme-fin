import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sme_fin/src/core/errors/app_exception.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppException appException;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        appException = const TimeoutException();
        break;
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode ?? 0;
        switch (statusCode) {
          case 400:
            appException = const BadRequestException();
            break;
          case 401:
            appException = const UnauthorizedException();
            break;
          case 403:
            appException = const ForbiddenException();
            break;
          case 404:
            appException = const NotFoundException();
            break;
          case 409:
            appException = const ConflictException();
            break;
          case 422:
            appException = const UnprocessableEntityException();
            break;
          case 429:
            appException = const RateLimitException();
            break;
          case 503:
            appException = const ServiceUnavailableException();
            break;
          case 500:
          default:
            appException = ServerException('Server error: $statusCode');
            break;
        }
        break;
      case DioExceptionType.cancel:
        appException = const UnknownException('Request cancelled');
        break;
      case DioExceptionType.unknown:
        if (err.error is SocketException) {
          appException = const NetworkException();
        } else {
          appException = UnknownException(err.message ?? 'Unknown error');
        }
        break;
      default:
        appException = UnknownException(err.message ?? 'Something went wrong');
    }

    /// Override server msg if available by api response
    var serverErrorMsg = _parseDioError(err);
    if (serverErrorMsg != null) {
      appException = appException.copyWith(message: serverErrorMsg);
    }

    /// forward the custom exception to upper layers
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: appException,
        type: err.type,
        response: err.response,
      ),
    );
  }

  String? _parseDioError(DioException e) {
    final data = e.response?.data;

    if (data == null) {
      return null;
    }

    /// If data is empty string or empty map/list, treat as no data:
    if (data is String && data.trim().isEmpty) {
      return null;
    }

    if (data is Iterable && data.isEmpty) {
      return null;
    }

    if (data is Map && data.isEmpty) {
      return null;
    }

    try {
      if (data is String) {
        /// Try parsing string response to JSON
        final parsed = jsonDecode(data);
        return _extractMessage(parsed);
      } else if (data is Map<String, dynamic>) {
        return _extractMessage(data);
      } else {
        return e.message ?? "Unexpected error format";
      }
    } catch (_) {
      return e.message ?? "Failed to parse error";
    }
  }

  String _extractMessage(Map<String, dynamic> data) {
    if (data.containsKey('data') && data['data'] is Map) {
      final errors = data['data'] as Map;
      for (var field in errors.keys) {
        final messages = errors[field];
        if (messages is List && messages.isNotEmpty) {
          return messages.first.toString();
        }
      }
    } else if (data.containsKey('message') && data['message'] is String) {
      return data['message'];
    } else if (data.containsKey('errors')) {
      final errors = data['errors'];
      if (errors is Map) {
        for (var field in errors.keys) {
          final messages = errors[field];
          if (messages is List && messages.isNotEmpty) {
            return messages.first.toString();
          }
        }
      } else if (errors is String) {
        return errors;
      }
    }

    return "Something went wrong";
  }
}
