import 'package:flutter/material.dart';
import 'package:frontend/features/auth/data/auth_repository.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final authRepository = AuthRepository();
  final formKey = GlobalKey<FormState>();

  final emailField = TextEditingController();
  final passwordField = TextEditingController();

  final RxBool isObscurePw = true.obs;

  bool getIsPwObscure() => isObscurePw.value;

  void toggleObscurePw() => isObscurePw.value = !isObscurePw.value;

  void signIn() {
    final response = authRepository.login(
      emailField.text,
      passwordField.text,
    );
  }
}
