import 'package:dio/dio.dart';
import 'package:frontend/features/auth/domain/clinic/clinic_model.dart';
import 'package:frontend/utils/dio/dio_client.dart';
import 'package:get/get.dart';

class VerifyClinicOwnerController extends GetxController {
  final DioClient dioClient = DioClient();

  final RxBool isLoading = true.obs;
  final clinicsForVerification = RxList<Clinic>().obs;

  Future<void> getClinicsForVerification() async {
    try {
      final response = await dioClient.get('clinics/verify');

      clinicsForVerification.value =
          response.data.map<Clinic>((json) => Clinic.fromJson(json)).toList();
      isLoading.value = false;
    } on DioException catch (e) {
      Get.back(); //hide dialog
      Get.snackbar(
        'Something went wrong ${e.toString()}',
        'Please try again later',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
