import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/common/widgets/custom_accent_button.dart';
import 'package:frontend/common/widgets/custom_primary_button.dart';
import 'package:frontend/common/widgets/cutom_text_field.dart';
import 'package:frontend/features/auth/presentation/login/login_controller.dart';
import 'package:frontend/styles/dark_theme.dart';
import 'package:frontend/styles/light_theme.dart';
import 'package:frontend/styles/text_styles.dart';
import 'package:frontend/utils/validator.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final loginController = Get.put(LoginController());

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
                Wrap(
                  alignment: WrapAlignment.start,
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
                Center(
                  child: Card(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 400,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Form(
                              key: loginController.formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomTextField(
                                    controller: loginController.emailField,
                                    prefixIcon: const Icon(Icons.email_rounded),
                                    labelText: 'Email',
                                    floatLabel: true,
                                    validator: Validator().email,
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  Obx(
                                    () => CustomTextField(
                                      controller: loginController.passwordField,
                                      borderRadius: BorderRadius.circular(5),
                                      floatLabel: true,
                                      labelText: 'Password',
                                      validator: Validator().notEmpty,
                                      prefixIcon: const Icon(Icons.lock),
                                      obscureText:
                                          loginController.getIsPwObscure(),
                                      suffixIcon: IconButton(
                                        onPressed: () =>
                                            loginController.toggleObscurePw(),
                                        icon: Icon(
                                          loginController.getIsPwObscure()
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 22.0,
                            ),
                            CustomAccentButton(
                              buttonLabel: 'Login',
                              onPressed: () {
                                loginController.signIn();
                              },
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Text(
                                    'or Register New Account',
                                    style: captionSemiboldPoppins.copyWith(
                                      color: lightNeutralColor,
                                    ),
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
                              buttonLabel: 'Register',
                              onPressed: () {
                                Navigator.popAndPushNamed(context, '/register');
                              },
                            ),
                          ],
                        ),
                      ),
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
