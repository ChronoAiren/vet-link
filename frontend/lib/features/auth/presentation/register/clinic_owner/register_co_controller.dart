import 'package:flutter/material.dart';
import 'package:frontend/features/auth/data/auth_repository.dart';
import 'package:get/get.dart';

class RegisterCOController extends GetxController {
  final authRepository = AuthRepository();
  final formKey = GlobalKey<FormState>();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final emailField = TextEditingController();
  final passwordField = TextEditingController();
  final confirmPasswordField = TextEditingController();
}
