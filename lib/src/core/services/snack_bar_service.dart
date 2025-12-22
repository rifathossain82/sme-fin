import 'package:flutter/material.dart';
import 'package:sme_fin/src/core/core.dart';

enum SnackBarType { success, error, warning, info }

class SnackBarService {
  static void show({
    required String message,
    SnackBarType type = SnackBarType.info,
    String? actionLabel,
    VoidCallback? onAction,
    int durationInSeconds = 3,
  }) {
    final scaffoldMessengerKey = sl.get<GlobalKey<ScaffoldMessengerState>>();
    final context = scaffoldMessengerKey.currentContext;

    if (context == null) return;

    final colorScheme = context.colorScheme;

    final backgroundColor = switch (type) {
      SnackBarType.success => Colors.green,
      SnackBarType.error => colorScheme.error,
      SnackBarType.warning => Colors.orange,
      SnackBarType.info => Colors.blueGrey,
    };

    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: type == SnackBarType.error
              ? colorScheme.onError
              : Colors.white,
        ),
      ),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: durationInSeconds),
      behavior: SnackBarBehavior.fixed,
      action: (actionLabel != null && onAction != null)
          ? SnackBarAction(
              label: actionLabel,
              textColor: Colors.white,
              onPressed: onAction,
            )
          : null,
    );

    scaffoldMessengerKey.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showSuccess(
    String message, {
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    show(
      message: message,
      type: SnackBarType.success,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  static void showError(
    String message, {
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    show(
      message: message,
      type: SnackBarType.error,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  static void showWarning(
    String message, {
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    show(
      message: message,
      type: SnackBarType.warning,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  static void showInfo(
    String message, {
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    show(
      message: message,
      type: SnackBarType.info,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }
}
