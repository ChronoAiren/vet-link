import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/styles/dark_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/register');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logos/icon-vetlink.png',
              width: 120.0,
            ),
            const SizedBox(
              height: 18.0,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/logos/logo-first-vetlink.svg',
                  semanticsLabel: 'VetLink Logo',
                  width: 100.0,
                ),
                SvgPicture.asset(
                  'assets/logos/logo-second-vetlink.svg',
                  semanticsLabel: 'VetLink Logo',
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).brightness == Brightness.dark
                        ? darkAccentColor
                        : Colors.black,
                    BlendMode.srcIn,
                  ),
                  width: 110.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
