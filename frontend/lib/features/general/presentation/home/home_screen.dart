import 'package:flutter/material.dart';
import 'package:frontend/common/controllers/session_controller.dart';
import 'package:frontend/common/widgets/main_wrapper.dart';
import 'package:frontend/styles/text_styles.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final SessionController sessionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return MainWrapper(
      content: Text(
        'Welcome, ${sessionController.currentUser?.givenName}!',
        style: subtitleSemiboldPoppins,
      ),
    );
  }
}
