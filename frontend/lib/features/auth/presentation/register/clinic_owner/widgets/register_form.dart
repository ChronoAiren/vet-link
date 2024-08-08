import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/cutom_text_field.dart';
import 'package:get/get.dart';

class RegisterForm extends StatelessWidget {
  RegisterForm({super.key});

  final RxBool isObscurePw = true.obs;
  final RxBool isObscureConfirmPw = true.obs;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            children: [
              Flexible(
                child: CustomTextField(
                  labelText: 'First Name',
                  floatLabel: true,
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Flexible(
                child: CustomTextField(
                  labelText: 'Last Name',
                  prefixIcon: Icon(Icons.person),
                  floatLabel: true,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          const CustomTextField(
            prefixIcon: Icon(Icons.email_rounded),
            labelText: 'Email',
            floatLabel: true,
          ),
          const SizedBox(
            height: 15.0,
          ),
          Obx(
            () => CustomTextField(
              borderRadius: BorderRadius.circular(5),
              floatLabel: true,
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock),
              obscureText: isObscurePw.value,
              suffixIcon: IconButton(
                onPressed: () {
                  isObscurePw.value = !(isObscurePw.value);
                },
                icon: Icon(
                  isObscurePw.value ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Obx(
            () => CustomTextField(
              borderRadius: BorderRadius.circular(5),
              floatLabel: true,
              labelText: 'Confirm Password',
              prefixIcon: const Icon(Icons.lock),
              obscureText: isObscureConfirmPw.value,
              suffixIcon: IconButton(
                onPressed: () {
                  isObscureConfirmPw.value = !(isObscureConfirmPw.value);
                },
                icon: Icon(
                  isObscureConfirmPw.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
