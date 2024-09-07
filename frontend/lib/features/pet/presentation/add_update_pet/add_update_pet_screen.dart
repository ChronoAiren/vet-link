import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_dropdown.dart';
import 'package:frontend/features/pet/domain/pet/pet_model.dart';
import 'package:frontend/features/pet/presentation/add_update_pet/add_update_pet_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddPetScreen extends StatelessWidget {
  const AddPetScreen({super.key, this.pet});
  final Pet? pet;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddPetController(pet));

    return Form(
      key: controller.formKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Add Pet',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Obx(
                        () => Radio(
                          value: 'Dog',
                          groupValue: controller.species.value,
                          onChanged: (value) {
                            controller.species.value = value!;
                            controller.changeOptionsFor('Dog');
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
                          value: 'Cat',
                          groupValue: controller.species.value,
                          onChanged: (value) {
                            controller.species.value = value!;
                            controller.changeOptionsFor('Cat');
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
            const TextField(
              decoration: InputDecoration(
                  hintText: 'Pet\'s Name', border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 15.0,
            ),
            CustomDropdown(
              controller: controller.genderField,
              dropdownItems: const ['Female', 'Male'],
              labelText: 'Gender',
            ),
            const SizedBox(
              height: 15.0,
            ),
            Obx(
              () => CustomDropdown(
                controller: controller.breedField,
                dropdownItems:
                    controller.breedOptions.map((e) => e.name).toList(),
                labelText: 'Breed',
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Obx(() {
              return TextField(
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
                      controller.selectedDate.value =
                          DateFormat('yyyy-MM-dd').format(pickeddate);
                    }
                  });
            }),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  child: const Text('Add Pet'),
                  onPressed: () {
                    controller.addPet();
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            ),
          ]),
    );
  }
}
