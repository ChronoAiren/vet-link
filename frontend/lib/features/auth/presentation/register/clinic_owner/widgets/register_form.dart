import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/cutom_text_field.dart';
import 'package:frontend/utils/validator.dart';
import 'package:get/get.dart';

class RegisterForm extends StatelessWidget {
  RegisterForm(
      {super.key,
      required this.formKey,
      required this.firstName,
      required this.lastName,
      required this.emailField,
      required this.passwordField});

  final RxBool isObscurePw = true.obs;
  final RxBool isObscureConfirmPw = true.obs;
  final GlobalKey<FormState> formKey;

  final TextEditingController firstName;
  final TextEditingController lastName;
  final TextEditingController emailField;
  final TextEditingController passwordField;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Flexible(
                child: CustomTextField(
                  controller: firstName,
                  labelText: 'First Name',
                  floatLabel: true,
                  prefixIcon: const Icon(Icons.person),
                  validator: Validator().notEmpty,
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Flexible(
                child: CustomTextField(
                  labelText: 'Last Name',
                  prefixIcon: const Icon(Icons.person),
                  floatLabel: true,
                  validator: Validator().notEmpty,
                  controller: lastName,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          CustomTextField(
            prefixIcon: const Icon(Icons.email_rounded),
            labelText: 'Email',
            floatLabel: true,
            validator: Validator().email,
            controller: emailField,
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
              validator: Validator().notEmpty,
              suffixIcon: IconButton(
                onPressed: () {
                  isObscurePw.value = !(isObscurePw.value);
                },
                icon: Icon(
                  isObscurePw.value ? Icons.visibility : Icons.visibility_off,
                ),
              ),
              controller: passwordField,
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
              validator: (value) {
                if (value == '') {
                  return 'This is a required field';
                } else if (passwordField.text != value) {
                  return 'Password does not match';
                } else {
                  return null;
                }
              },
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
