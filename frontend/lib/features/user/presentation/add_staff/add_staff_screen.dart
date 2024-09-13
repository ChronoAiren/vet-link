import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_accent_button.dart';
import 'package:frontend/common/widgets/cutom_text_field.dart';
import 'package:frontend/features/user/presentation/add_staff/add_staff_controller.dart';
import 'package:frontend/styles/light_theme.dart';
import 'package:frontend/styles/text_styles.dart';
import 'package:frontend/utils/validator.dart';
import 'package:get/get.dart';

class AddStaffScreen extends StatelessWidget {
  AddStaffScreen({super.key});

  final controller = Get.put(AddStaffController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 400,
            maxWidth: 600,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    labelText: 'First Name',
                    prefixIcon: const Icon(Icons.person),
                    floatLabel: true,
                    validator: Validator().notEmpty,
                    controller: controller.firstNameField,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  CustomTextField(
                    labelText: 'Last Name',
                    prefixIcon: const Icon(Icons.person),
                    floatLabel: true,
                    validator: Validator().notEmpty,
                    controller: controller.lastNameField,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  CustomTextField(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.person),
                    floatLabel: true,
                    validator: Validator().email,
                    controller: controller.lastNameField,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Tooltip(
                        message: 'Veterinarian',
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(
                              () => Radio(
                                value: "VETERINARIAN STAFF",
                                groupValue: controller.userRole.value,
                                onChanged: (value) {
                                  controller.userRole.value = value!;
                                },
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Tooltip(
                                message: 'Veterinarian',
                                child: Image.asset(
                                  'assets/icons/vet.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Tooltip(
                        message: 'Receptionist',
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(
                              () => Radio(
                                value: "RECEPTIONIST STAFF",
                                groupValue: controller.userRole.value,
                                onChanged: (value) {
                                  controller.userRole.value = value!;
                                },
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Image.asset(
                                'assets/icons/receptionist.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Using default password of "12345". \nPlease advise employees to change their passwords.',
                      style: captionRegularPoppins.copyWith(
                        fontStyle: FontStyle.italic,
                        color: lightOnSurfaceColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 22.0,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 120.0,
                      child: ElevatedButton(
                        child: const Text('Add Staff'),
                        onPressed: () {
                          controller.addStaff();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
