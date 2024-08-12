import 'package:flutter/material.dart';
import 'package:frontend/common/controllers/bindings.dart';
import 'package:frontend/features/auth/presentation/login/login_screen.dart';
import 'package:frontend/features/auth/presentation/register/clinic_owner/page/register_co_screen.dart';
import 'package:frontend/features/auth/presentation/register/pet_owner/page/register_screen.dart';
import 'package:frontend/features/general/presentation/home/home_screen.dart';
import 'package:frontend/features/user/presentation/add_staff/add_staff_screen.dart';
import 'package:frontend/features/user/presentation/verify_clinic_owner/verify_clinic_owner_screen.dart';
import 'package:frontend/features/user/presentation/view_staffs/view_staffs_screen.dart';
import 'package:frontend/splash_screen.dart';
import 'package:frontend/styles/dark_theme.dart';
import 'package:frontend/styles/light_theme.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AllControllerBinding(),
      builder: (context, child) => ResponsiveBreakpoints.builder(
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
        child: child!,
      ),
      title: 'VetLink',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: '/home',
      getPages: [
        // '/': (context) => const SplashScreen(),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/register', page: () => RegisterPetOwnerScreen()),
        GetPage(name: '/register_co', page: () => RegisterClinicOwnerScreen()),
        GetPage(
            name: '/verify_clinic_owner',
            page: () => VerifyClinicOwnerScreen()),
        GetPage(name: '/view_staffs', page: () => ViewStaffsScreen()),
        GetPage(name: '/add_staff', page: () => AddStaffScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
      ],
    );
  }
}
