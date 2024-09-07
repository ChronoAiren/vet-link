import 'package:dio/dio.dart';
import 'package:frontend/common/controllers/session_controller.dart';
import 'package:frontend/features/auth/domain/user/user_model.dart';
import 'package:frontend/utils/dio/dio_client.dart';
import 'package:get/get.dart';

class ViewStaffsController extends GetxController {
  final SessionController sessionController = Get.find();
  final DioClient dioClient = DioClient();

  final RxBool isLoading = true.obs;
  RxList<User> staffs = RxList.empty(growable: true);

  @override
  void onInit() {
    super.onInit();
    getStaffs();
  }

  Future<void> getStaffs() async {
    int clinicId = sessionController.currentClinic?.id ?? -1;

    if (clinicId == -1) {
      Get.snackbar(
        'Cannot detect a clinic you are affiliated with.',
        'Please try again later',
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading.value = false;
      return;
    }

    try {
      final response = await dioClient.get('employees/$clinicId');
      staffs.addAll(
          response.data.map<User>((json) => User.fromJson(json)).toList());
    } on DioException catch (e) {
      Get.snackbar(
        'Something went wrong',
        'Please try again later',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
