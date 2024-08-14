import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/main_wrapper.dart';
import 'package:frontend/styles/light_theme.dart';
import 'package:frontend/styles/text_styles.dart';

class VerifyClinicOwnerScreen extends StatelessWidget {
  VerifyClinicOwnerScreen({super.key});

  final List<Map<String, String>> clinicOwnerRegistration = [
    {
      'firstName': 'Jake',
      'lastName': 'Peralta',
      'clinic': '99th Precinct Veterinary',
      'location': 'Brooklyn',
      'businessPermit': '123-3434-24543-3434'
    },
    {
      'firstName': 'Amy',
      'lastName': 'Santiago',
      'clinic': 'Santiago Pet Care',
      'location': 'Queens',
      'businessPermit': '123-3434-24543-3434'
    },
    {
      'firstName': 'Rosa',
      'lastName': 'Diaz',
      'clinic': 'Diaz Animal Clinic',
      'location': 'Manhattan',
      'businessPermit': '123-3434-24543-3434'
    },
    {
      'firstName': 'Terry',
      'lastName': 'Jeffords',
      'clinic': 'Jeffords Family Vet',
      'location': 'Brooklyn',
      'businessPermit': '123-3434-24543-3434'
    },
    {
      'firstName': 'Charles',
      'lastName': 'Boyle',
      'clinic': 'Boyle’s Best Buddies Vet',
      'location': 'Brooklyn',
      'businessPermit': '123-3434-24543-3434'
    },
    {
      'firstName': 'Holt',
      'lastName': 'Raymond',
      'clinic': 'Holt Veterinary Services',
      'location': 'Brooklyn',
      'businessPermit': '123-3434-24543-3434'
    },
    {
      'firstName': 'Gina',
      'lastName': 'Linetti',
      'clinic': 'Linetti Animal Care',
      'location': 'Staten Island',
      'businessPermit': '123-3434-24543-3434'
    },
    {
      'firstName': 'Kevin',
      'lastName': 'Cozner',
      'clinic': 'Cozner Companion Care',
      'location': 'Manhattan',
      'businessPermit': '123-3434-24543-3434'
    },
    {
      'firstName': 'Adrian',
      'lastName': 'Pimento',
      'clinic': 'Pimento Vet Clinic',
      'location': 'Queens',
      'businessPermit': '123-3434-24543-3434'
    },
  ];

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
              child: ListView.builder(
                  padding: const EdgeInsets.only(
                    bottom: 15.0,
                  ),
                  shrinkWrap: true,
                  itemCount: clinicOwnerRegistration.length,
                  itemBuilder: (context, index) {
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Name',
                                    style: smallSemiboldPoppins,
                                  ),
                                  Text(
                                    '${clinicOwnerRegistration[index]['firstName']} ${clinicOwnerRegistration[index]['lastName']}',
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
                                    '${clinicOwnerRegistration[index]['clinic']}',
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
                                    '${clinicOwnerRegistration[index]['location']}',
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
                                    '${clinicOwnerRegistration[index]['businessPermit']}',
                                    style: smallRegularPoppins,
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  child: const Text(
                                    'Decline',
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
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${clinicOwnerRegistration[index]['clinic']}',
                                style: bodyRegularPoppins,
                              ),
                              Text(
                                '${clinicOwnerRegistration[index]['location']}',
                                style: smallSemiboldPoppins,
                              ),
                              Text(
                                'Owned by: ${clinicOwnerRegistration[index]['firstName']} ${clinicOwnerRegistration[index]['lastName']}',
                                style: smallRegularPoppins,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
