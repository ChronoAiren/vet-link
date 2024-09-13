import 'package:flutter/material.dart';
import 'package:frontend/common/controllers/drawer_controller.dart';
import 'package:frontend/common/controllers/session_controller.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:frontend/common/constants/routes.dart';
import 'package:frontend/styles/dark_theme.dart';
import 'package:frontend/styles/light_theme.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<SessionController>(SessionController(), permanent: true);
  Get.put<CustomDrawerController>(CustomDrawerController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // initialBinding: AllControllerBinding(),
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
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
