import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/cutom_text_field.dart';
import 'package:frontend/utils/validator.dart';

class ClinicForm extends StatelessWidget {
  ClinicForm({
    super.key,
    required this.nameField,
    required this.locationField,
    required this.permitField,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  final TextEditingController nameField;
  final TextEditingController locationField;
  final TextEditingController permitField;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            prefixIcon: const Icon(Icons.local_hospital),
            labelText: 'Clinic Name',
            floatLabel: true,
            controller: nameField,
            validator: Validator().notEmpty,
          ),
          const SizedBox(
            height: 15.0,
          ),
          CustomTextField(
            prefixIcon: const Icon(Icons.pin_drop),
            labelText: 'Location',
            floatLabel: true,
            controller: locationField,
            validator: Validator().notEmpty,
          ),
          const SizedBox(
            height: 15.0,
          ),
          CustomTextField(
            prefixIcon: const Icon(Icons.numbers),
            labelText: 'Business Permit No.',
            floatLabel: true,
            controller: permitField,
            validator: Validator().notEmpty,
          ),
        ],
      ),
    );
  }
}
