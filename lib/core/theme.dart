import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData theme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      elevation: 2,
      centerTitle: true,
    ),
    textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'lilitaone-regular-webfont',
        ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}
