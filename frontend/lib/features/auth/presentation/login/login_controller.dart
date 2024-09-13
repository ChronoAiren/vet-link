import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/controllers/session_controller.dart';
import 'package:frontend/features/auth/domain/clinic/clinic_model.dart';
import 'package:frontend/features/auth/domain/user/user_model.dart';
import 'package:frontend/utils/dio/dio_client.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final SessionController sessionController = Get.find();
  final DioClient dioClient = DioClient();
  final formKey = GlobalKey<FormState>();

  final emailField = TextEditingController();
  final passwordField = TextEditingController();

  final RxBool isObscurePw = true.obs;

  bool getIsPwObscure() => isObscurePw.value;

  void toggleObscurePw() => isObscurePw.value = !isObscurePw.value;

  Future<void> signIn() async {
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
          'login',
          data: {
            "email": emailField.text,
            "password": passwordField.text,
          },
        );

        final user = User.fromJson(response.data);

        if (user.userRole == 'UNVERIFIED CLINIC OWNER') {
          Get.back(); //hide dialog
          Get.snackbar(
            'UNVERIFIED',
            'Please wait to be verified first',
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }

        sessionController.setCurrentUser(user);

        if (user.userRole == 'CLINIC OWNER') {
          final Clinic clinic = await getClinic(user.id);
          sessionController.setCurrentClinic(clinic);
        }

        Get.back(); //hide dialog
        Get.offAndToNamed('/home');
      } on DioException catch (e) {
        Get.back(); //hide dialog
        Get.snackbar(
          'Error logging in',
          'Please check your email and password',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  Future<Clinic> getClinic(int userId) async {
    final response = await dioClient.get('clinic-owners/$userId');
    final clinic = Clinic.fromJson(response.data);
    return clinic;
  }
}
