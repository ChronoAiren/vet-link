import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/cutom_text_field.dart';

class ClinicForm extends StatelessWidget {
  const ClinicForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Form(
      child: Column(
        children: [
          CustomTextField(
            prefixIcon: Icon(Icons.local_hospital),
            labelText: 'Clinic Name',
            floatLabel: true,
          ),
          SizedBox(
            height: 15.0,
          ),
          CustomTextField(
            prefixIcon: Icon(Icons.pin_drop),
            labelText: 'Location',
            floatLabel: true,
          ),
          SizedBox(
            height: 15.0,
          ),
          CustomTextField(
            prefixIcon: Icon(Icons.numbers),
            labelText: 'Business Permit No.',
            floatLabel: true,
          ),
        ],
      ),
    );
  }
}
