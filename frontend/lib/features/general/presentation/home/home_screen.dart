import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/main_wrapper.dart';
import 'package:frontend/styles/text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainWrapper(
      content: const Text(
        'Welcome, Jake!',
        style: subtitleSemiboldPoppins,
      ),
    );
  }
}
