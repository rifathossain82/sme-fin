/// Base exception
class AppException implements Exception {
  final String message;
  const AppException(this.message);

  AppException copyWith({String? message}) =>
      AppException(message ?? this.message);

  @override
  String toString() => message;
}

/// 5xx - Server-side errors
class ServerException extends AppException {
  const ServerException([super.message = 'Server error']);
}

/// No internet / no connection
class NetworkException extends AppException {
  const NetworkException([super.message = 'No internet connection']);
}

/// Request timeout
class TimeoutException extends AppException {
  const TimeoutException([super.message = 'Request timeout']);
}

/// 400 - Bad request
class BadRequestException extends AppException {
  const BadRequestException([super.message = '400 - Bad request']);
}

/// 401 - Unauthorized
class UnauthorizedException extends AppException {
  const UnauthorizedException([super.message = '401 - Unauthorized']);
}

/// 403 - Forbidden (you may separate it from 401)
class ForbiddenException extends AppException {
  const ForbiddenException([super.message = '403 - Forbidden']);
}

/// 404 - Not Found
class NotFoundException extends AppException {
  const NotFoundException([super.message = '404 - Not found']);
}

/// 409 - Conflict (e.g., duplicate data)
class ConflictException extends AppException {
  const ConflictException([super.message = '409 - Conflict']);
}

/// 422 - Validation failed
class UnprocessableEntityException extends AppException {
  const UnprocessableEntityException([super.message = '422 - Validation error']);
}

/// 503 - Service Unavailable
class ServiceUnavailableException extends AppException {
  const ServiceUnavailableException([super.message = '503 - Service unavailable']);
}

/// 429 - Too Many Requests
class RateLimitException extends AppException {
  const RateLimitException([super.message = 'Too Many Requests']);
}

/// Parsing / unexpected data
class ParseException extends AppException {
  const ParseException([super.message = 'Unable To Parse Data']);
}

/// Unexpected or unmapped error
class UnknownException extends AppException {
  const UnknownException([super.message = 'Unknown error occurred']);
}

/// Cache error
class CacheException extends AppException {
  const CacheException([super.message = 'Cache error']);
}