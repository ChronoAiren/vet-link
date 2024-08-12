import 'package:flutter/material.dart';

class ViewPetScreen extends StatelessWidget {
  const ViewPetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold (
        appBar: AppBar (
          title: Text('my pets'),
        ),
      )
    );
  }
}