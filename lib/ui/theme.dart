import 'dart:async';

import 'package:flutter/material.dart';

class FlyThemeData {
  final String fontFamily;
  final MaterialColor primary;
  final MaterialColor secondary;

  FlyThemeData(
      {this.fontFamily = 'Roboto',
      this.primary = Colors.pink,
      this.secondary = Colors.blue});
}

class ThemeManager {
  StreamController _streamController = StreamController.broadcast();

  FlyThemeData _theme = FlyThemeData();

  FlyThemeData get data => _theme;

  ThemeData get materialTheme => ThemeData(
      accentColor: data.secondary,
      primaryColor: data.primary,
      fontFamily: data.fontFamily);

  Stream get changeStream => _streamController.stream;

  void use(FlyThemeData theme) {
    _theme = theme;
    _streamController.add('changed');
  }

  void dispose() {
    _streamController.close();
  }
}

ThemeManager applicationTheme = ThemeManager();
