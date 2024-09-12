import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/controllers/session_controller.dart';
import 'package:frontend/features/auth/domain/user/user_model.dart';
import 'package:frontend/utils/dio/dio_client.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final SessionController sessionController = Get.find();
  final DioClient dioClient = DioClient();
  final formKey = GlobalKey<FormState>();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final emailField = TextEditingController();
  final passwordField = TextEditingController();
  final confirmPasswordField = TextEditingController();

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      Get.defaultDialog(
        title: 'Loading...',
        content: const CircularProgressIndicator(),
        barrierDismissible: false,
      );

      // Wait for 3 seconds before proceeding
      await Future.delayed(const Duration(seconds: 1));

      try {
        final response = await dioClient.post(
          'register',
          data: {
            "Email": emailField.text,
            "Password": passwordField.text,
            "GivenName": firstName.text,
            "FamilyName": lastName.text,
          },
        );

        final user = User.fromJson(response.data);
        sessionController.setCurrentUser(user);

        Get.back(); //hide dialog
        Get.offAndToNamed('/home');
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
}
