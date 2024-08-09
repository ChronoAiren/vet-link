import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/styles/dark_theme.dart';
import 'package:frontend/styles/light_theme.dart';
import 'package:frontend/styles/text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: lightSecondaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.menu),
                  color: Colors.white,
                  onPressed: () {},
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Text(
                  'Home',
                  style: bodyBoldPoppins.copyWith(color: Colors.white),
                )
              ],
            ),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/logos/bg-vetlink.png',
              ),
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logos/icon-vetlink.png',
                    width: 60.0,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  SvgPicture.asset(
                    'assets/logos/logo-first-vetlink.svg',
                    semanticsLabel: 'VetLink Logo',
                    height: 60.0,
                  ),
                  SvgPicture.asset(
                    'assets/logos/logo-second-vetlink.svg',
                    semanticsLabel: 'VetLink Logo',
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).brightness == Brightness.dark
                            ? darkAccentColor
                            : Colors.black,
                        BlendMode.srcIn),
                    height: 60.0,
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'Welcome, Jake!',
                style: subtitleSemiboldPoppins,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'Test Screens:',
                style: smallSemiboldPoppins,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/verify_clinic_owner');
                },
                child: const Text(
                  'Verify Clinic Owner Registrations',
                  style: smallSemiboldPoppins,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/view_staffs');
                },
                child: const Text(
                  'View Staffs',
                  style: smallSemiboldPoppins,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
