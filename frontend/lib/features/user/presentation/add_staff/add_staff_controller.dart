import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/controllers/session_controller.dart';
import 'package:frontend/features/auth/domain/user/user_model.dart';
import 'package:frontend/utils/dio/dio_client.dart';
import 'package:get/get.dart';

class AddStaffController extends GetxController {
  final SessionController sessionController = Get.find();
  final DioClient dioClient = DioClient();
  final formKey = GlobalKey<FormState>();

  final firstNameField = TextEditingController();
  final lastNameField = TextEditingController();
  final emailField = TextEditingController();
  final RxString userRole = 'Veterinarian'.obs;

  Future<void> addStaff() async {
    int clinicId = sessionController.currentClinic?.id ?? -1;

    if (clinicId == -1) {
      Get.snackbar(
        'Cannot detect a clinic you are affiliated with.',
        'Please try again later',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

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
          'employees/${userRole.value == 'VETERINARIAN STAFF' ? 'veterinarian' : 'receptionist'}',
          data: {
            "id": clinicId,
            "email": emailField.text,
            "givenName": firstNameField.text,
            "familyName": lastNameField.text,
            "password": '12345',
          },
        );

        final user = User.fromJson(response.data);
        sessionController.setCurrentUser(user);
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
