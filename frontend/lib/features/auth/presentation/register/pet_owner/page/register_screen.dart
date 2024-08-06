import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/common/widgets/cutom_text_field.dart';
import 'package:frontend/styles/dark_theme.dart';
import 'package:frontend/styles/light_theme.dart';
import 'package:get/get.dart';

class RegisterPetOwnerScreen extends StatelessWidget {
  RegisterPetOwnerScreen({super.key});

  final RxBool isObscurePw = true.obs;
  final RxBool isObscureConfirmPw = true.obs;

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
              Form(
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Flexible(
                          child: CustomTextField(
                            labelText: 'First Name',
                            floatLabel: true,
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Flexible(
                          child: CustomTextField(
                            labelText: 'Last Name',
                            prefixIcon: Icon(Icons.person),
                            floatLabel: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const CustomTextField(
                      prefixIcon: Icon(Icons.email_rounded),
                      labelText: 'Email',
                      floatLabel: true,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Obx(
                      () => CustomTextField(
                        borderRadius: BorderRadius.circular(5),
                        floatLabel: true,
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        obscureText: isObscurePw.value,
                        suffixIcon: IconButton(
                          onPressed: () {
                            isObscurePw.value = !(isObscurePw.value);
                          },
                          icon: Icon(
                            isObscurePw.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Obx(
                      () => CustomTextField(
                        borderRadius: BorderRadius.circular(5),
                        floatLabel: true,
                        labelText: 'Confirm Password',
                        prefixIcon: const Icon(Icons.lock),
                        obscureText: isObscureConfirmPw.value,
                        suffixIcon: IconButton(
                          onPressed: () {
                            isObscureConfirmPw.value =
                                !(isObscureConfirmPw.value);
                          },
                          icon: Icon(
                            isObscureConfirmPw.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 22.0,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 10.0,
                        ),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: lightAccentColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: lightDarkNeutralColor,
                              offset: Offset(0, 2),
                              blurRadius: 5.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                        ),
                        child: const Text(
                          'REGISTER',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
