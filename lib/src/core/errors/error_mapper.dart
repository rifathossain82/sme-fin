import 'errors.dart';

extension FailureMapper on AppException {
  Failure get toFailure => mapAppExceptionToFailure(this);
}

Failure mapAppExceptionToFailure(AppException e) {
  if (e is NetworkException) return NetworkFailure(e.message);
  if (e is TimeoutException) return TimeoutFailure(e.message);
  if (e is ServerException) return ServerFailure(e.message);
  if (e is ServiceUnavailableException) return ServiceUnavailableFailure(e.message);
  if (e is BadRequestException) return BadRequestFailure(e.message);
  if (e is UnauthorizedException) return UnauthorizedFailure(e.message);
  if (e is ForbiddenException) return ForbiddenFailure(e.message);
  if (e is NotFoundException) return NotFoundFailure(e.message);
  if (e is ConflictException) return ConflictFailure(e.message);
  if (e is UnprocessableEntityException) return UnprocessableEntityFailure(e.message);
  if (e is RateLimitException) return RateLimitFailure(e.message);
  if (e is ParseException) return ParseFailure(e.message);

  return UnknownFailure(e.message);
}

