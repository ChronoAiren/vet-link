import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_dropdown.dart';
import 'package:frontend/common/widgets/cutom_text_field.dart';
import 'package:frontend/features/pet/domain/pet/pet_model.dart';
import 'package:frontend/features/pet/presentation/add_update_pet/add_update_pet_controller.dart';
import 'package:frontend/utils/validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class AddPetScreen extends StatelessWidget {
  AddPetScreen({super.key, this.pet});
  final Pet? pet;
  late AddPetController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(AddPetController(pet));

    return Form(
      key: controller.formKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Obx(
                        () => Radio(
                          value: 'DOG',
                          groupValue: controller.species.value,
                          onChanged: (value) {
                            controller.species.value = value!;
                            controller.changeOptionsFor('DOG');
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text('Dog'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Obx(
                        () => Radio(
                          value: 'CAT',
                          groupValue: controller.species.value,
                          onChanged: (value) {
                            controller.species.value = value!;
                            controller.changeOptionsFor('CAT');
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text('Cat'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            CustomTextField(
              labelText: 'Pet\'s Name',
              floatLabel: true,
              validator: Validator().notEmpty,
              controller: controller.petNameField,
            ),
            const SizedBox(
              height: 15.0,
            ),
            CustomDropdown(
              controller: controller.genderField,
              dropdownItems: const ['Female', 'Male'],
              labelText: 'Gender',
              validator: Validator().notEmpty,
            ),
            const SizedBox(
              height: 15.0,
            ),
            CustomDropdown(
              controller: controller.breedField,
              dropdownItems:
                  controller.breedOptions.map((e) => e.breed).toList(),
              labelText: 'Breed',
              validator: Validator().notEmpty,
            ),
            const SizedBox(
              height: 15.0,
            ),
            TextFormField(
              validator: Validator().notEmpty,
              controller: controller.dateController,
              decoration: const InputDecoration(
                labelText: 'Birthdate',
              ),
              onTap: () async {
                DateTime? pickeddate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now());

                if (pickeddate != null) {
                  controller.dateController.text =
                      DateFormat('yyyy-MM-dd').format(pickeddate);
                }
              },
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  child: Text('${pet == null ? "Add" : "Update"} Pet'),
                  onPressed: () async {
                    if (pet == null) {
                      await controller.addPet();
                    } else {
                      await controller.updatePet();
                    }
                  },
                ),
              ],
            ),
          ]),
    );
  }
}
