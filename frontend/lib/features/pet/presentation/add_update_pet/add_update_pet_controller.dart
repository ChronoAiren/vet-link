import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/controllers/session_controller.dart';
import 'package:frontend/features/pet/domain/breed/breed_model.dart';
import 'package:frontend/features/pet/domain/pet/pet_model.dart';
import 'package:frontend/features/pet/presentation/view_pets/view_pets_controller.dart';
import 'package:frontend/utils/dio/dio_client.dart';
import 'package:get/get.dart';

class AddPetController extends GetxController {
  final SessionController sessionController = Get.find();
  final DioClient dioClient = DioClient();
  final formKey = GlobalKey<FormState>();

  final petNameField = TextEditingController();
  final RxString species = 'Dog'.obs;
  final RxList<Breed> catBreed = <Breed>[].obs;
  final RxList<Breed> dogBreed = <Breed>[].obs;
  final RxList<Breed> breedOptions = <Breed>[].obs;
  final genderField = TextEditingController();
  final breedField = TextEditingController();
  final defaultDate = DateTime.now();
  final dateController = TextEditingController();
  final RxString selectedDate = ''.obs;

  final ViewPetsController _viewPetsController = Get.find();

  Pet? selectedPet;

  AddPetController(this.selectedPet);

  @override
  Future<void> onInit() async {
    super.onInit();
    await getCatBreeds();
    await getDogreeds();

    if (selectedPet != null) {
      petNameField.text = selectedPet!.name;
      genderField.text = selectedPet!.gender;
      selectedDate.value = selectedPet!.birthdate;
      breedField.text = selectedPet!.breed.breed;
      species.value = selectedPet!.breed.species!;
      changeOptionsFor(species.value);
    } else {
      breedOptions.value = dogBreed;
    }
    dateController.text = selectedDate.value;
  }

  void changeOptionsFor(String selectedSpecies) {
    species.value = selectedSpecies;
    breedField.clear();
    breedOptions.value = selectedSpecies == 'Dog' ? dogBreed : catBreed;
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
    int userId = sessionController.currentUser?.id ?? 3;

    if (userId == -1) {
      Get.snackbar(
        'User not logged in',
        'Please try again later',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (formKey.currentState!.validate() &&
        genderField.text != "" &&
        breedField.text != "") {
      Get.defaultDialog(
        title: 'Loading...',
        content: const CircularProgressIndicator(),
        barrierDismissible: false,
      );

      // Wait for 3 seconds before proceeding
      await Future.delayed(const Duration(seconds: 1));

      int breedId =
          breedOptions.firstWhere((e) => e.breed == breedField.text).id;
      debugPrint(dateController.text);
      try {
        final response = await dioClient.post(
          'pets',
          data: {
            "name": petNameField.text,
            "gender": genderField.text == "Male" ? 0 : 1,
            "birthdate": dateController.text,
            "breedId": breedId,
            "ownerId": userId,
          },
        );

        final newPet = Pet.fromJson(response.data);
        _viewPetsController.pets.add(newPet);
        Get.back(); //hide dialog
        Get.back(); //hide form
        Get.snackbar(
          'Successfully',
          '${newPet.name} is added as new pet.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } on DioException catch (e) {
        Get.back(); //hide dialog
        Get.snackbar(
          'Error adding pet',
          '${e.toString()}. Please try again later',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  Future<void> updatePet() async {
    if (selectedPet != null) {
      if (formKey.currentState!.validate() && selectedDate.value != '') {
        Get.defaultDialog(
          title: 'Loading...',
          content: const CircularProgressIndicator(),
          barrierDismissible: false,
        );

        // Wait for 3 seconds before proceeding
        await Future.delayed(const Duration(seconds: 1));

        int breedId =
            breedOptions.firstWhere((e) => e.breed == breedField.text).id;

        try {
          final response = await dioClient.patch(
            'pets/${selectedPet!.id}',
            data: {
              "name": petNameField.text,
              "gender": genderField.text,
              "birthdate": selectedDate.value,
              "breedId": breedId,
            },
          );

          final updatedPet = Pet.fromJson(response.data);
          //update ui list
          Get.back(); //hide dialog
          Get.back(); //hide form
          Get.snackbar(
            'Successfully',
            '${updatedPet.name} is updated.',
            snackPosition: SnackPosition.BOTTOM,
          );
        } on DioException catch (e) {
          Get.back(); //hide dialog
          Get.snackbar(
            'Error updating pet',
            'Please try again later',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    }
  }
}
