import 'package:flutter/material.dart';
import 'package:frontend/styles/text_styles.dart';

// Dark Mode Text Styles
TextTheme darkTextTheme = TextTheme(
  displayLarge: headerBoldPoppins.copyWith(color: darkOnBackgroundColor),
  displayMedium: subtitleBoldPoppins.copyWith(color: darkOnBackgroundColor),
  bodyLarge: bodyBoldPoppins.copyWith(color: darkOnBackgroundColor),
  bodyMedium: smallBoldPoppins.copyWith(color: darkOnBackgroundColor),
  bodySmall: captionBoldPoppins.copyWith(color: darkOnBackgroundColor),
);

// Dark Mode Colors
const Color darkPrimaryColor = Color(0xFF0097B2); // Blue-Green
const Color darkSecondaryColor = Color(0xFF0CC0DF); // Cyan
const Color darkAccentColor = Color(0xFFFFBD59); // Mango Tango

const Color darkLightNeutralColor =
    Color(0xFF2C2C2C); // Darker Gray for light neutral
const Color darkNeutralColor = Color(0xFF9E9E9E); // Gray
const Color darkDarkNeutralColor = Color(0xFF616161); // Dark Gray

const Color darkBackgroundColor =
    Color(0xFF121212); // Dark Background (not pure black)
const Color darkSurfaceColor =
    Color(0xFF1E1E1E); // Surface color for cards and other elements
const Color darkOnBackgroundColor =
    Color(0xFFE0E0E0); // Text and icons on dark background
const Color darkOnSurfaceColor =
    Color(0xFFE0E0E0); // Text and icons on surfaces

InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
  filled: true,
  fillColor: darkBackgroundColor, // Background color for the input field
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(
      color: darkDarkNeutralColor, // Color of the border when not focused
      width: 2,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(
      color: darkAccentColor, // Color of the border when focused
      width: 2,
    ),
  ),
  hintStyle: const TextStyle(
    color: darkNeutralColor,
    fontSize: 16,
    fontFamily: 'Poppins',
  ),
  labelStyle: const TextStyle(
    color: darkOnBackgroundColor,
    fontSize: 16,
    fontFamily: 'Poppins',
  ),
  errorStyle: const TextStyle(
    color: Colors.red,
    fontSize: 14,
    fontFamily: 'Poppins',
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: darkPrimaryColor,
  hintColor: darkAccentColor,
  scaffoldBackgroundColor: darkBackgroundColor,
  textTheme: darkTextTheme,
  buttonTheme: const ButtonThemeData(
    buttonColor: darkAccentColor,
    textTheme: ButtonTextTheme.primary,
  ),
  inputDecorationTheme: darkInputDecorationTheme,
);
