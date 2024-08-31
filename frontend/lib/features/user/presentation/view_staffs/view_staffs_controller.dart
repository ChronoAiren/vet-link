import 'package:dio/dio.dart';
import 'package:frontend/common/controllers/session_controller.dart';
import 'package:frontend/features/auth/domain/user/user_model.dart';
import 'package:frontend/utils/dio/dio_client.dart';
import 'package:get/get.dart';

class ViewStaffsController extends GetxController {
  final SessionController sessionController = Get.find();
  final DioClient dioClient = DioClient();

  final RxBool isLoading = true.obs;
  final staffs = RxList<User>().obs;

  Future<void> getStaffs() async {
    int clinicId = sessionController.currentClinic?.id ?? -1;

    if (clinicId == -1) {
      //Cannot detect a clinic you are affiliated with.
      return;
    }

    try {
      final response = await dioClient.get('staffs/$clinicId');

      staffs.value =
          response.data.map<User>((json) => User.fromJson(json)).toList();
      isLoading.value = false;
    } on DioException catch (e) {
      Get.back(); //hide dialog
      Get.snackbar(
        'Something went wrong',
        'Please try again later',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
