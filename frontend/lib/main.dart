import 'package:flutter/material.dart';
import 'package:frontend/features/auth/presentation/login/login_screen.dart';
import 'package:frontend/features/auth/presentation/register/clinic_owner/page/register_co_screen.dart';
import 'package:frontend/features/auth/presentation/register/pet_owner/page/register_screen.dart';
import 'package:frontend/features/general/presentation/home/home_screen.dart';
import 'package:frontend/features/user/presentation/add_staff/add_staff_screen.dart';
import 'package:frontend/features/user/presentation/verify_clinic_owner/verify_clinic_owner_screen.dart';
import 'package:frontend/features/user/presentation/view_staffs/view_staffs_screen.dart';
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
      initialRoute: '/login',
      routes: {
        // '/': (context) => const SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterPetOwnerScreen(),
        '/register_co': (context) => RegisterClinicOwnerScreen(),
        '/verify_clinic_owner': (context) => VerifyClinicOwnerScreen(),
        '/view_staffs': (context) => ViewStaffsScreen(),
        '/add_staff': (context) => AddStaffScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
