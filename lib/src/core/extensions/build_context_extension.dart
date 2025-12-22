import 'dart:math';
import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  void unFocusKeyboard() {
    if (FocusScope.of(this).hasFocus) FocusScope.of(this).unfocus();
  }

  dynamic get getArguments => ModalRoute.of(this)?.settings.arguments;

  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
  Size get screenSize => MediaQuery.of(this).size;

  double get minScreenSize => min(screenHeight, screenWidth);
  double get maxScreenSize => max(screenHeight, screenWidth);

  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  void openDrawer() => Scaffold.of(this).openDrawer();
  void closeDrawer() => Scaffold.of(this).closeDrawer();
  void openEndDrawer() => Scaffold.of(this).openEndDrawer();
  void closeEndDrawer() => Scaffold.of(this).closeEndDrawer();

  bool get isDrawerOpen => Scaffold.of(this).isDrawerOpen;
  bool get isEndDrawerOpen => Scaffold.of(this).isEndDrawerOpen;

  /// For theme-based access
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  ThemeData get theme => Theme.of(this);
}
