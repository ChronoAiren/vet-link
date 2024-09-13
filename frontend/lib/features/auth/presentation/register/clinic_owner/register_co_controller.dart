import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/dio/dio_client.dart';
import 'package:get/get.dart';

class RegisterCOController extends GetxController {
  final DioClient dioClient = DioClient();
  final registerFormKey = GlobalKey<FormState>();
  final clinicFormKey = GlobalKey<FormState>();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final emailField = TextEditingController();
  final passwordField = TextEditingController();
  final confirmPasswordField = TextEditingController();

  final nameField = TextEditingController();
  final locationField = TextEditingController();
  final permitField = TextEditingController();

  final RxInt activeStep = 1.obs;

  void prevStep() {
    if (activeStep.value > 1) {
      activeStep.value -= 1;
    }
  }

  void nextStep() {
    //if in last step, proceed to register
    if (activeStep.value == 3) {
      register();
    } else {
      if (activeStep.value == 1) {
        //validate register form in step 1 before next step
        if (!registerFormKey.currentState!.validate()) {
          return;
        }
      } else if (activeStep.value == 2) {
        //validate clinic form in step 2 before next step
        if (!clinicFormKey.currentState!.validate()) {
          return;
        }
      }
      activeStep.value += 1;
    }
  }

  Future<void> register() async {
    Get.defaultDialog(
      title: 'Loading...',
      content: const CircularProgressIndicator(),
      barrierDismissible: false,
    );

    // Wait for 3 seconds before proceeding
    await Future.delayed(const Duration(seconds: 1));

    try {
      await dioClient.post(
        'clinic-owners',
        data: {
          "email": emailField.text,
          "password": passwordField.text,
          "givenName": firstName.text,
          "familyName": lastName.text,
          "name": nameField.text,
          "location": locationField.text,
          "businessNo": permitField.text,
        },
      );

      Get.back();
      Get.toNamed('/login'); //hide dialog
      Get.snackbar(
        'Done registering',
        'Please wait for your clinic registration request to be verified',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on DioException catch (e) {
      Get.back(); //hide dialog
      Get.snackbar(
        'Error registering',
        'Please try again later',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
