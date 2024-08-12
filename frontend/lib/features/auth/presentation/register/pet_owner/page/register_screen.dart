import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/common/widgets/custom_accent_button.dart';
import 'package:frontend/common/widgets/custom_primary_button.dart';
import 'package:frontend/features/auth/presentation/register/clinic_owner/widgets/register_form.dart';
import 'package:frontend/styles/dark_theme.dart';
import 'package:frontend/styles/light_theme.dart';
import 'package:frontend/styles/text_styles.dart';

class RegisterPetOwnerScreen extends StatelessWidget {
  const RegisterPetOwnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(
              vertical: 35.0,
              horizontal: 20.0,
            ),
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
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
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
                  height: 30.0,
                ),
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RegisterForm(),
                        const SizedBox(
                          height: 22.0,
                        ),
                        CustomAccentButton(
                          buttonLabel: 'Register',
                          onPressed: () {},
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/register_co');
                            },
                            child: const Text(
                              'Register as Clinic Owner',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(
                              child: Divider(
                                thickness: 1,
                                color: lightNeutralColor,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'or Login Your Account',
                                style: captionSemiboldPoppins.copyWith(
                                    color: lightNeutralColor),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                thickness: 1,
                                color: lightNeutralColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        CustomPrimaryButton(
                          buttonLabel: 'Login',
                          onPressed: () {
                            Navigator.popAndPushNamed(context, '/login');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
