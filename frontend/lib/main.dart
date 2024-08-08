import 'package:flutter/material.dart';
import 'package:frontend/features/auth/presentation/register/clinic_owner/page/register_co_screen.dart';
import 'package:frontend/features/auth/presentation/register/pet_owner/page/register_screen.dart';
import 'package:frontend/splash_screen.dart';
import 'package:frontend/styles/dark_theme.dart';
import 'package:frontend/styles/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VetLink',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/register': (context) => RegisterPetOwnerScreen(),
        '/register_co': (context) => RegisterClinicOwnerScreen(),
      },
    );
  }
}
