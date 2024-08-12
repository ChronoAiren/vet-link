import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_accent_button.dart';
import 'package:frontend/common/widgets/custom_primary_button.dart';
import 'package:frontend/features/auth/presentation/register/clinic_owner/widgets/clinic_form.dart';
import 'package:frontend/features/auth/presentation/register/clinic_owner/widgets/register_form.dart';
import 'package:frontend/styles/light_theme.dart';
import 'package:frontend/styles/text_styles.dart';
import 'package:get/get.dart';

class RegisterClinicOwnerScreen extends StatelessWidget {
  RegisterClinicOwnerScreen({super.key});

  RxInt activeStep = 1.obs;

  void prevStep() {
    if (activeStep.value > 1) {
      activeStep.value -= 1;
    }
  }

  void nextStep() {
    if (activeStep.value == 3) {
      // submit
    } else {
      activeStep.value += 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
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
                Obx(
                  () => SizedBox(
                    height: 100.0,
                    child: EasyStepper(
                      activeStep: activeStep.value,
                      borderThickness: 2,
                      finishedStepBorderColor: lightAccentColor,
                      finishedStepTextColor: lightAccentColor,
                      finishedStepBackgroundColor: lightAccentColor,
                      activeStepIconColor: lightAccentColor,
                      showLoadingAnimation: false,
                      steps: const [
                        EasyStep(
                          icon: Icon(Icons.account_box),
                        ),
                        EasyStep(
                          icon: Icon(Icons.local_hospital),
                        ),
                        EasyStep(
                          icon: Icon(Icons.check_circle_outline),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Obx(
                  () => Visibility(
                    visible: activeStep.value == 1,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: RegisterForm(),
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: activeStep.value == 2,
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 30.0),
                      child: ClinicForm(),
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: activeStep.value == 3,
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 30.0),
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Review Details',
                                style: bodySemiboldPoppins,
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Name',
                                    style: bodySemiboldPoppins,
                                  ),
                                  Text(
                                    'Jake Peralta',
                                    style: bodyRegularPoppins,
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    'Username',
                                    style: bodySemiboldPoppins,
                                  ),
                                  Text(
                                    'jakey123',
                                    style: bodyRegularPoppins,
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    'Clinic',
                                    style: bodySemiboldPoppins,
                                  ),
                                  Text(
                                    'Floydie Veterinary Clinic',
                                    style: bodyRegularPoppins,
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    'Location',
                                    style: bodySemiboldPoppins,
                                  ),
                                  Text(
                                    'Dahlia, Visayan Village, Tagum City, Davao del Norte',
                                    style: bodyRegularPoppins,
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    'Business Permit',
                                    style: bodySemiboldPoppins,
                                  ),
                                  Text(
                                    '2323-45421-2344-6788',
                                    style: bodyRegularPoppins,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Obx(
                        () => CustomPrimaryButton(
                          withShadow: true,
                          buttonLabel: 'Prev',
                          enabled: activeStep.value != 1,
                          onPressed: () => prevStep(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Obx(
                        () => CustomAccentButton(
                          withShadow: true,
                          buttonLabel:
                              activeStep.value == 3 ? 'Submit' : 'Next',
                          onPressed: () => nextStep(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Obx(
                  () => Visibility(
                    visible: activeStep.value == 1,
                    child: Column(
                      children: [
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
                                'or',
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
                        SizedBox(
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, '/register');
                            },
                            child: const Text(
                              'Register as Pet Owner',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
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
