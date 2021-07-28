import 'package:flutter/material.dart';
class MyColors {
  static const Color primaryColor = Colors.orange;
  static const Color primaryColorLight = Colors.black;
}
class AppTheme {
  static final light = ThemeData(
    primarySwatch: Colors.orange,

    brightness: Brightness.light,
    accentColor: Colors.orange,
    disabledColor: Colors.grey.shade400,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    accentColor: Colors.orange,
    disabledColor: Colors.grey.shade400,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}