abstract class Failure {
  final String message;
  final int? code;

  Failure(this.message, [this.code]);
}

/// 5xx - Server errors
class ServerFailure extends Failure {
  ServerFailure(super.message, [super.code]);
}

/// 503 - Service unavailable
class ServiceUnavailableFailure extends Failure {
  ServiceUnavailableFailure(super.message, [super.code]);
}

/// No internet connection
class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}

/// Request timeout
class TimeoutFailure extends Failure {
  TimeoutFailure(super.message);
}

/// 400 - Bad request
class BadRequestFailure extends Failure {
  BadRequestFailure(super.message, [super.code]);
}

/// 401 - Unauthorized
class UnauthorizedFailure extends Failure {
  UnauthorizedFailure(super.message, [super.code]);
}

/// 403 - Forbidden
class ForbiddenFailure extends Failure {
  ForbiddenFailure(super.message, [super.code]);
}

/// 404 - Not found
class NotFoundFailure extends Failure {
  NotFoundFailure(super.message, [super.code]);
}

/// 409 - Conflict
class ConflictFailure extends Failure {
  ConflictFailure(super.message, [super.code]);
}

/// 422 - Validation failed
class UnprocessableEntityFailure extends Failure {
  UnprocessableEntityFailure(super.message, [super.code]);
}

/// 429 - Too many requests / rate limit
class RateLimitFailure extends Failure {
  RateLimitFailure(super.message, [super.code]);
}

/// Parsing / unexpected data
class ParseFailure extends Failure {
  ParseFailure(super.message);
}

/// Unexpected / fallback
class UnknownFailure extends Failure {
  UnknownFailure(super.message);
}

/// Cache error
class CacheFailure extends Failure {
  CacheFailure(super.message);
}