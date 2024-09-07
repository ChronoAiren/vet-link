import 'package:dio/dio.dart';
import 'package:frontend/common/controllers/session_controller.dart';
import 'package:frontend/features/auth/domain/clinic/clinic_model.dart';
import 'package:frontend/features/auth/domain/user/user_model.dart';
import 'package:frontend/utils/dio/dio_client.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final SessionController sessionController = Get.find();
  final DioClient dioClient = DioClient();

  final RxBool isLoading = true.obs;
  RxList<Clinic> clinics = RxList.empty(growable: true);

  @override
  void onInit() {
    super.onInit();
    getClinics();
  }

  Future<void> getClinics() async {
    try {
      final response = await dioClient.get('clinic-owners?verified=true');

      final List<Clinic> clinicsFromApi = response.data
          .map<Clinic>(
            (json) => Clinic.fromJson(json),
          )
          .toList();

      clinics.addAll(clinicsFromApi);
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
}
