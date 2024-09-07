import 'package:flutter/material.dart';
import 'package:frontend/common/controllers/session_controller.dart';
import 'package:frontend/common/widgets/main_wrapper.dart';
import 'package:frontend/features/general/presentation/home/home_controller.dart';
import 'package:frontend/styles/light_theme.dart';
import 'package:frontend/styles/text_styles.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final SessionController sessionController = Get.find();
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return MainWrapper(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome, ${sessionController.currentUser?.givenName}!',
            style: subtitleSemiboldPoppins,
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Obx(
              () => controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: lightAccentColor,
                      ),
                    )
                  : controller.clinics.isEmpty
                      ? const Center(
                          child: Text(
                            'No clinics to verify at the moment',
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.only(
                            bottom: 15.0,
                          ),
                          shrinkWrap: true,
                          itemCount: controller.clinics.length,
                          itemBuilder: (context, index) {
                            final clinicVerifInfo = controller.clinics[index];

                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      clinicVerifInfo.name,
                                      style: bodyRegularPoppins,
                                    ),
                                    Text(
                                      clinicVerifInfo.location,
                                      style: smallSemiboldPoppins,
                                    ),
                                    Text(
                                      'Owned by: ${clinicVerifInfo.owner.givenName} ${clinicVerifInfo.owner.familyName}',
                                      style: smallRegularPoppins,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
