import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/controllers/session_controller.dart';
import 'package:frontend/features/auth/domain/user/user_model.dart';
import 'package:frontend/features/pet/domain/breed/breed_model.dart';
import 'package:frontend/features/pet/domain/pet/pet_model.dart';
import 'package:frontend/utils/dio/dio_client.dart';
import 'package:get/get.dart';

class AddPetController extends GetxController {
  final SessionController sessionController = Get.find();
  final DioClient dioClient = DioClient();
  final formKey = GlobalKey<FormState>();

  final firstNameField = TextEditingController();
  final RxString species = 'Dog'.obs;
  final RxList<Breed> catBreed = <Breed>[].obs;
  final RxList<Breed> dogBreed = <Breed>[].obs;
  final RxList<Breed> breedOptions = <Breed>[].obs;
  final genderField = TextEditingController();
  final breedField = TextEditingController();
  final defaultDate = DateTime.now();
  final dateController = TextEditingController();
  final RxString selectedDate = ''.obs;

  Pet? selectedPet;

  AddPetController(this.selectedPet);

  @override
  Future<void> onInit() async {
    super.onInit();
    await getCatBreeds();
    await getDogreeds();

    if (selectedPet != null) {
      firstNameField.text = selectedPet!.name;
      genderField.text = selectedPet!.gender;
      selectedDate.value = selectedPet!.birthdate;
      breedField.text = selectedPet!.breeds.name;
      species.value = selectedPet!.species.name;
      changeOptionsFor(selectedPet!.species.name);
    } else {
      breedOptions.value = dogBreed;
    }
    dateController.text = selectedDate.value;
  }

  void changeOptionsFor(String selectedSpecies) {
    species.value = selectedSpecies;
    breedField.clear();
    breedOptions.value = [];
    breedOptions.value = species.value == 'Dog' ? dogBreed : catBreed;
  }

  Future<void> getCatBreeds() async {
    try {
      final response = await dioClient.get('pets/breeds?species=2');

      catBreed.value =
          response.data.map<Breed>((json) => Breed.fromJson(json)).toList();
    } on DioException catch (e) {
      Get.snackbar(
        'Something went wrong ${e.toString()}',
        'Please try again later',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> getDogreeds() async {
    try {
      final response = await dioClient.get('pets/breeds?species=1');

      dogBreed.value =
          response.data.map<Breed>((json) => Breed.fromJson(json)).toList();
    } on DioException catch (e) {
      Get.snackbar(
        'Something went wrong ${e.toString()}',
        'Please try again later',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> addPet() async {
    int userId = sessionController.currentUser?.id ?? -1;

    if (userId == -1) {
      Get.snackbar(
        'User not logged in',
        'Please try again later',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (formKey.currentState!.validate() && selectedDate.value != '') {
      Get.defaultDialog(
        title: 'Loading...',
        content: const CircularProgressIndicator(),
        barrierDismissible: false,
      );

      // Wait for 3 seconds before proceeding
      await Future.delayed(const Duration(seconds: 1));

      int breedId =
          breedOptions.firstWhere((e) => e.name == breedField.text).id;

      try {
        final response = await dioClient.post(
          'add-pet',
          data: {
            "name": firstNameField.text,
            "gender": genderField.text,
            "birthDate": selectedDate.value,
            "breedId": breedId,
            "species": species.value
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
