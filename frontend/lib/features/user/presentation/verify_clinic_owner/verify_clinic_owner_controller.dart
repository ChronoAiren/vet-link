import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/controllers/session_controller.dart';
import 'package:frontend/features/auth/domain/clinic/clinic_model.dart';
import 'package:frontend/utils/dio/dio_client.dart';
import 'package:get/get.dart';

class VerifyClinicOwnerController extends GetxController {
  final SessionController sessionController = Get.find();
  final DioClient dioClient = DioClient();

  final RxBool isLoading = true.obs;
  RxList<Clinic> clinicsForVerification = RxList.empty(growable: true);

  @override
  void onInit() {
    super.onInit();
    getClinicsForVerification();
  }

  Future<void> getClinicsForVerification() async {
    try {
      final response = await dioClient.get('clinic-owners?verified=false');

      final List<Clinic> clinicsFromApi = response.data
          .map<Clinic>(
            (json) => Clinic.fromJson(json),
          )
          .toList();

      clinicsForVerification.addAll(clinicsFromApi);
    } on DioException catch (e) {
      Get.back();
      Get.snackbar(
        'Something went wrong ${e.toString()}',
        'Please try again later',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> approveRegistration(int clinicId) async {
    Get.defaultDialog(
      title: 'Loading...',
      content: const CircularProgressIndicator(),
      barrierDismissible: false,
    );

    try {
      await dioClient.get('clinic-owners/$clinicId/verify');
      return true;
    } on DioException catch (e) {
      Get.back();
      Get.snackbar(
        'Something went wrong ${e.toString()}',
        'Please try again later',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
