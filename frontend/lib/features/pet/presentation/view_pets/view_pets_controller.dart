import 'package:dio/dio.dart';
import 'package:frontend/common/controllers/session_controller.dart';
import 'package:frontend/features/pet/domain/pet/pet_model.dart';
import 'package:frontend/utils/dio/dio_client.dart';
import 'package:get/get.dart';

class ViewPetsController extends GetxController {
  final SessionController sessionController = Get.find();
  final DioClient dioClient = DioClient();

  final RxBool isLoading = true.obs;
  RxList<Pet> pets = RxList.empty(growable: true);

  @override
  Future<void> onInit() async {
    super.onInit();
    await getPets();
  }

  Future<void> getPets() async {
    int userId = sessionController.currentUser?.id ?? -1;

    if (userId == -1) {
      Get.snackbar(
        'User not logged in',
        'Please try again later',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      final response = await dioClient.get('pets?ownerId=$userId');
      final List<Pet> petsFromApi =
          response.data.map<Pet>((json) => Pet.fromJson(json)).toList();
      pets.addAll(petsFromApi);
    } on DioException catch (e) {
      Get.back(); //hide dialog
      Get.snackbar(
        'Something went wrong ${e.toString()}',
        'Please try again later',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deletePet(
    int petId,
  ) async {
    try {
      await dioClient.delete('pets/$petId');
      return true;
    } on DioException catch (e) {
      Get.snackbar(
        'Something went wrong ${e.toString()}',
        'Please try again later',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }
}
