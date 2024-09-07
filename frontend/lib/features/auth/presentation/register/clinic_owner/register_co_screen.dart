import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_accent_button.dart';
import 'package:frontend/common/widgets/custom_primary_button.dart';
import 'package:frontend/features/auth/presentation/register/clinic_owner/register_co_controller.dart';
import 'package:frontend/features/auth/presentation/register/clinic_owner/widgets/clinic_form.dart';
import 'package:frontend/features/auth/presentation/register/clinic_owner/widgets/register_form.dart';
import 'package:frontend/styles/light_theme.dart';
import 'package:frontend/styles/text_styles.dart';
import 'package:get/get.dart';

class RegisterClinicOwnerScreen extends StatelessWidget {
  RegisterClinicOwnerScreen({super.key});

  final registerCoController = Get.put(RegisterCOController());

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
                      activeStep: registerCoController.activeStep.value,
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
                Center(
                  child: Card(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 400,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Obx(
                              () => Visibility(
                                visible:
                                    registerCoController.activeStep.value == 1,
                                child: RegisterForm(
                                  formKey: registerCoController.registerFormKey,
                                  firstName: registerCoController.firstName,
                                  lastName: registerCoController.lastName,
                                  emailField: registerCoController.emailField,
                                  passwordField:
                                      registerCoController.passwordField,
                                ),
                              ),
                            ),
                            Obx(
                              () => Visibility(
                                visible:
                                    registerCoController.activeStep.value == 2,
                                child: ClinicForm(
                                  formKey: registerCoController.clinicFormKey,
                                  nameField: registerCoController.nameField,
                                  locationField:
                                      registerCoController.locationField,
                                  permitField: registerCoController.permitField,
                                ),
                              ),
                            ),
                            Obx(
                              () => Visibility(
                                visible:
                                    registerCoController.activeStep.value == 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 30.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        'Review Details',
                                        style: bodySemiboldPoppins,
                                      ),
                                      const SizedBox(
                                        height: 30.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Name',
                                            style: bodySemiboldPoppins,
                                          ),
                                          Text(
                                            "${registerCoController.firstName.text} ${registerCoController.lastName.text}",
                                            style: bodyRegularPoppins,
                                          ),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          const Text(
                                            'Email',
                                            style: bodySemiboldPoppins,
                                          ),
                                          Text(
                                            registerCoController
                                                .emailField.text,
                                            style: bodyRegularPoppins,
                                          ),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          const Text(
                                            'Clinic',
                                            style: bodySemiboldPoppins,
                                          ),
                                          Text(
                                            registerCoController.nameField.text,
                                            style: bodyRegularPoppins,
                                          ),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          const Text(
                                            'Location',
                                            style: bodySemiboldPoppins,
                                          ),
                                          Text(
                                            registerCoController
                                                .locationField.text,
                                            style: bodyRegularPoppins,
                                          ),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          const Text(
                                            'Business Permit',
                                            style: bodySemiboldPoppins,
                                          ),
                                          Text(
                                            registerCoController
                                                .permitField.text,
                                            style: bodyRegularPoppins,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 17,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Obx(
                                    () => CustomPrimaryButton(
                                      buttonLabel: 'Prev',
                                      enabled: registerCoController
                                              .activeStep.value !=
                                          1,
                                      onPressed: () =>
                                          registerCoController.prevStep(),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  child: Obx(
                                    () => CustomAccentButton(
                                      buttonLabel: registerCoController
                                                  .activeStep.value ==
                                              3
                                          ? 'Submit'
                                          : 'Next',
                                      onPressed: () =>
                                          registerCoController.nextStep(),
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
                                visible:
                                    registerCoController.activeStep.value == 1,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                            'or',
                                            style:
                                                captionSemiboldPoppins.copyWith(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
