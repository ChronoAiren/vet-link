import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/main_wrapper.dart';
import 'package:get/get.dart';

class AddPetScreen extends StatelessWidget {
  const AddPetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainWrapper(
      content: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Text('add pet screen')],
        ),
      ),
      fab: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: Colors.limeAccent,
          onPressed: () {
            Get.back();
          }),
    );
  }
}
