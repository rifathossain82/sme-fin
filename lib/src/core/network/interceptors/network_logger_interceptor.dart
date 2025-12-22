import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sme_fin/src/core/helpers/helpers.dart';

sealed class ConsoleColor {
  static const reset = '\x1B[0m';
  static const red = '\x1B[31m';
  static const green = '\x1B[32m';
  static const yellow = '\x1B[33m';
  static const blue = '\x1B[34m';
  static const magenta = '\x1B[35m';
  static const cyan = '\x1B[36m';
  static const gray = '\x1B[90m';
}

class NetworkLoggerInterceptor extends Interceptor {
  static const _sensitiveKeys = ['authorization', 'password', 'token'];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!kDebugMode) return handler.next(options);

    final startTime = DateTime.now();
    options.extra['startTime'] = startTime;

    final buffer = StringBuffer();
    buffer.writeln(
      '${ConsoleColor.cyan}┌─ REQUEST ───────────────────────────────────────────────────${ConsoleColor.reset}',
    );
    buffer.writeln('│ METHOD     : ${options.method}');
    buffer.writeln('│ URL        : ${options.uri}');
    buffer.writeln('│ TIME       : $startTime');

    if (options.headers.isNotEmpty) {
      buffer.writeln(
        '│ HEADERS    :\n${_indentJson(_maskSensitiveData(options.headers))}',
      );
    }

    if (options.queryParameters.isNotEmpty) {
      buffer.writeln(
        '│ QUERY PARAMS:\n${_indentJson(options.queryParameters)}',
      );
    }

    if (options.data != null) {
      buffer.writeln(
        '│ BODY       :\n${_indentJson(_maskSensitiveData(options.data))}',
      );
    }

    buffer.writeln(
      '${ConsoleColor.cyan}└──────────────────────────────────────────────────────────────${ConsoleColor.reset}',
    );

    Log.info(buffer.toString());
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (!kDebugMode) return handler.next(response);

    final request = response.requestOptions;
    final startTime = request.extra['startTime'] as DateTime?;
    final endTime = DateTime.now();
    final duration = startTime != null
        ? endTime.difference(startTime).inMilliseconds
        : null;

    final buffer = StringBuffer();
    buffer.writeln(
      '${ConsoleColor.green}┌─ RESPONSE ───────────────────────────────────────────────────${ConsoleColor.reset}',
    );
    buffer.writeln('│ URL        : ${request.uri}');
    buffer.writeln('│ STATUS     : ${response.statusCode}');
    if (duration != null) buffer.writeln('│ DURATION   : ${duration}ms');
    buffer.writeln('│ DATA       :\n${_indentJson(response.data)}');
    buffer.writeln(
      '${ConsoleColor.green}└──────────────────────────────────────────────────────────────${ConsoleColor.reset}',
    );

    Log.info(buffer.toString());
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (!kDebugMode) return handler.next(err);

    final request = err.requestOptions;

    final buffer = StringBuffer();
    buffer.writeln(
      '${ConsoleColor.red}┌─ ERROR ──────────────────────────────────────────────────────${ConsoleColor.reset}',
    );
    buffer.writeln('│ URL        : ${request.uri}');
    buffer.writeln('│ STATUS     : ${err.response?.statusCode}');
    buffer.writeln('│ MESSAGE    : ${err.message}');
    if (err.response?.data != null) {
      buffer.writeln('│ ERROR DATA :\n${_indentJson(err.response?.data)}');
    }
    buffer.writeln(
      '${ConsoleColor.red}└──────────────────────────────────────────────────────────────${ConsoleColor.reset}',
    );

    Log.error(buffer.toString());
    handler.next(err);
  }

  static String _indentJson(dynamic data) {
    try {
      if (data is Map || data is List) {
        return const JsonEncoder.withIndent(
          '  ',
        ).convert(data).split('\n').map((line) => '│   $line').join('\n');
      }
      return '│   ${data.toString()}';
    } catch (e) {
      return '│   🚫 Failed to format JSON: $e';
    }
  }

  static Map<String, dynamic> _maskSensitiveData(dynamic data) {
    if (data is! Map<String, dynamic>) return data;

    return data.map((key, value) {
      if (_sensitiveKeys.contains(key.toString().toLowerCase())) {
        return MapEntry(key, '****');
      }
      return MapEntry(key, value);
    });
  }
}
