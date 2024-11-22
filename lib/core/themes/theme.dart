import 'package:flutter/material.dart';

final theme = ThemeData(
  primaryColor: const Color(0xFF7ED4AD),
  colorScheme: ColorScheme.fromSeed(
    primary: const Color(0xFF7ED4AD),
    secondary: const Color(0xFFD76C82),
    seedColor: const Color(0xFF7ED4AD),
    tertiary: const Color(0xFF3D0301),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    prefixIconColor: Color(0xFF7ED4AD),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Color(0xFFE0E0E0)),
    ),
    filled: true,
    fillColor: Color(0xFFFAFAFA),
    hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
  ),
  dropdownMenuTheme: const DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: Color(0xFF7ED4AD),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: Color(0xFFE0E0E0)),
      ),
      filled: true,
      fillColor: Color(0xFFFAFAFA),
      hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
    ),
    textStyle: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  ),
  useMaterial3: true,
);
