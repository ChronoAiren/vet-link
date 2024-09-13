import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/main_wrapper.dart';
import 'package:frontend/features/pet/presentation/add_update_pet/add_update_pet_screen.dart';
import 'package:frontend/features/pet/presentation/view_pets/view_pets_controller.dart';
import 'package:frontend/styles/dark_theme.dart';
import 'package:frontend/styles/light_theme.dart';
import 'package:get/get.dart';

class ViewPetsScreen extends StatelessWidget {
  ViewPetsScreen({super.key});

  final controller = Get.put(ViewPetsController());

  @override
  Widget build(BuildContext context) {
    return MainWrapper(
      content: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 12, 192, 223),
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              child: const Text(
                'User\'s pets',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Expanded(
              child: Obx(() => controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: lightAccentColor,
                      ),
                    )
                  : controller.pets.isEmpty
                      ? const Center(
                          child: Text(
                            'You have no registered pet',
                          ),
                        )
                      : ListView.builder(
                          itemCount: controller.pets.length,
                          itemBuilder: (context, index) {
                            final pet = controller.pets[index];
                            return Dismissible(
                              key: UniqueKey(),
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 20),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              direction: DismissDirection.endToStart,
                              confirmDismiss: (direction) async {
                                return await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Confirm Deletion"),
                                      content: Text(
                                        "Are you sure you want to delete ${pet.name}?",
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: const Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          child: const Text("Delete"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              onDismissed: (direction) async {
                                final isDeleted =
                                    await controller.deletePet(pet.id);
                                if (isDeleted) {
                                  controller.pets.removeAt(index);
                                  Get.snackbar(
                                    "Deleted Successfully!",
                                    "${pet.name} has been deleted",
                                  );
                                }
                              },
                              child: ListTile(
                                onTap: () => Get.dialog(
                                  AlertDialog(
                                    backgroundColor:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? darkPrimaryColor
                                            : Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    content: SizedBox(
                                      width:
                                          kIsWeb ? Get.width * 0.35 : Get.width,
                                      child: AddPetScreen(
                                        pet: pet,
                                      ),
                                    ),
                                  ),
                                ),
                                title: Text(pet.name),
                                leading: CircleAvatar(
                                    backgroundImage: AssetImage(
                                  pet.breed.species == 'DOG'
                                      ? 'assets/icons/dog.png'
                                      : 'assets/icons/cat.jpg',
                                )),
                              ),
                            );
                          })),
            )
          ],
        ),
      ),
      fab: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: const Color.fromARGB(255, 255, 189, 89),
        onPressed: () => Get.dialog(
          AlertDialog(
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? darkPrimaryColor
                : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: SizedBox(
              width: kIsWeb ? Get.width * 0.35 : Get.width,
              child: AddPetScreen(),
            ),
          ),
        ),
        tooltip: 'Add Pet',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
