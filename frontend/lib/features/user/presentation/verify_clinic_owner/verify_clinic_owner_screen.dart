import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/main_wrapper.dart';
import 'package:frontend/features/user/presentation/verify_clinic_owner/verify_clinic_owner_controller.dart';
import 'package:frontend/styles/light_theme.dart';
import 'package:frontend/styles/text_styles.dart';
import 'package:get/get.dart';

class VerifyClinicOwnerScreen extends StatelessWidget {
  VerifyClinicOwnerScreen({super.key});

  final controller = Get.put(VerifyClinicOwnerController());

  @override
  Widget build(BuildContext context) {
    return MainWrapper(
      content: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              decoration: const BoxDecoration(
                color: lightSecondaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              child: Text(
                'Clinic Registration Request',
                style: captionBoldPoppins.copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: lightAccentColor,
                        ),
                      )
                    : controller.clinicsForVerification.isEmpty
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
                            itemCount: controller.clinicsForVerification.length,
                            itemBuilder: (context, index) {
                              final clinicVerifInfo =
                                  controller.clinicsForVerification[index];

                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                          'Registration Request',
                                          style: bodyBoldPoppins,
                                        ),
                                        content: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              'Name',
                                              style: smallSemiboldPoppins,
                                            ),
                                            Text(
                                              '${clinicVerifInfo.owner.givenName} ${clinicVerifInfo.owner.familyName}',
                                              style: smallRegularPoppins,
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            const Text(
                                              'Clinic',
                                              style: smallSemiboldPoppins,
                                            ),
                                            Text(
                                              clinicVerifInfo.name,
                                              style: smallRegularPoppins,
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            const Text(
                                              'Location',
                                              style: smallSemiboldPoppins,
                                            ),
                                            Text(
                                              clinicVerifInfo.location,
                                              style: smallRegularPoppins,
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            const Text(
                                              'Business Permit',
                                              style: smallSemiboldPoppins,
                                            ),
                                            Text(
                                              clinicVerifInfo.businessPermit,
                                              style: smallRegularPoppins,
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            },
                                          ),
                                          TextButton(
                                            child: const Text(
                                              'Approve',
                                              style: TextStyle(
                                                color: lightSecondaryColor,
                                              ),
                                            ),
                                            onPressed: () async {
                                              final isUpdated = await controller
                                                  .approveRegistration(
                                                clinicVerifInfo.id,
                                              );
                                              if (isUpdated) {
                                                controller
                                                    .clinicsForVerification
                                                    .removeAt(index);
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                ),
                              );
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
