import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/common/widgets/custom_accent_button.dart';
import 'package:frontend/features/auth/presentation/register/clinic_owner/widgets/register_form.dart';
import 'package:frontend/styles/dark_theme.dart';

class RegisterPetOwnerScreen extends StatelessWidget {
  RegisterPetOwnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 35.0,
            horizontal: 30.0,
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
              RegisterForm(),
              const SizedBox(
                height: 22.0,
              ),
              CustomAccentButton(
                buttonLabel: 'Register',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
