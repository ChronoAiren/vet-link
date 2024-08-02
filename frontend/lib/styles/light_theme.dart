import 'package:flutter/material.dart';
import 'package:frontend/styles/text_styles.dart';

// Light Mode Text Styles
TextTheme lightTextTheme = TextTheme(
  displayLarge: headerBoldPoppins.copyWith(color: lightOnBackgroundColor),
  displayMedium: subtitleBoldPoppins.copyWith(color: lightOnBackgroundColor),
  bodyLarge: bodyBoldPoppins.copyWith(color: lightOnBackgroundColor),
  bodyMedium: smallBoldPoppins.copyWith(color: lightOnBackgroundColor),
  bodySmall: captionBoldPoppins.copyWith(color: lightOnBackgroundColor),
);

// Light Mode Colors
const Color lightPrimaryColor = Color(0xFF0097B2); // Blue-Greens
const Color lightSecondaryColor = Color(0xFF0CC0DF); // Cyan
const Color lightAccentColor = Color(0xFFFFBD59); // Mango Tango

const Color lightLightNeutralColor = Color(0xFFF5F5F5); // Light Gray
const Color lightNeutralColor = Color(0xFF9E9E9E); // Gray
const Color lightDarkNeutralColor = Color(0xFF616161); // Dark Gray

const Color lightBackgroundColor = Color(0xFFFAFAFA); // Off-Whites
const Color lightSurfaceColor =
    Color(0xFFF5F5F5); // Light surface color for cards and other elements
const Color lightOnBackgroundColor =
    Color(0xFF000000); // Text and icons on light background
const Color lightOnSurfaceColor =
    Color(0xFF000000); // Text and icons on surfaces

InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
  filled: true,
  fillColor: lightBackgroundColor, // Background color for the input field
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(
      color: lightDarkNeutralColor, // Color of the border when not focused
      width: 2,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(
      color: lightAccentColor, // Color of the border when focused
      width: 2,
    ),
  ),
  hintStyle: const TextStyle(
    color: lightNeutralColor,
    fontSize: 16,
    fontFamily: 'Poppins',
  ),
  labelStyle: const TextStyle(
    color: lightOnBackgroundColor,
    fontSize: 16,
    fontFamily: 'Poppins',
  ),
  errorStyle: const TextStyle(
    color: Colors.red,
    fontSize: 14,
    fontFamily: 'Poppins',
  ),
);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: lightPrimaryColor,
  hintColor: lightAccentColor,
  scaffoldBackgroundColor: lightBackgroundColor,
  textTheme: lightTextTheme,
  buttonTheme: const ButtonThemeData(
    buttonColor: lightAccentColor,
    textTheme: ButtonTextTheme.primary,
  ),
  inputDecorationTheme: lightInputDecorationTheme,
);
