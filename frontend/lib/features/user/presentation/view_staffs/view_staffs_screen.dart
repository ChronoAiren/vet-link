import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/styles/dark_theme.dart';
import 'package:frontend/styles/light_theme.dart';
import 'package:frontend/styles/text_styles.dart';
import 'package:get/get.dart';

class ViewStaffsScreen extends StatelessWidget {
  ViewStaffsScreen({super.key});

  final RxList<Map<String, String>> clinicStaffs = [
    {
      'firstName': 'Jake',
      'lastName': 'Peralta',
      'userRole': 'Receptionist',
    },
    {
      'firstName': 'Amy',
      'lastName': 'Santiago',
      'userRole': 'Veterinarian',
    },
    {
      'firstName': 'Rosa',
      'lastName': 'Diaz',
      'userRole': 'Veterinarian',
    },
    {
      'firstName': 'Terry',
      'lastName': 'Jeffords',
      'userRole': 'Veterinarian',
    },
    {
      'firstName': 'Charles',
      'lastName': 'Boyle',
      'userRole': 'Receptionist',
    },
    {
      'firstName': 'Holt',
      'lastName': 'Raymond',
      'userRole': 'Receptionist',
    },
    {
      'firstName': 'Gina',
      'lastName': 'Linetti',
      'userRole': 'Receptionist',
    },
    {
      'firstName': 'Kevin',
      'lastName': 'Cozner',
      'userRole': 'Veterinarian',
    },
    {
      'firstName': 'Adrian',
      'lastName': 'Pimento',
      'userRole': 'Veterinarian',
    },
  ].obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: lightSecondaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: lightAccentColor,
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/add_staff');
          },
          tooltip: 'Add Staff',
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/logos/bg-vetlink.png',
              ),
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logos/icon-vetlink.png',
                    width: 60.0,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  SvgPicture.asset(
                    'assets/logos/logo-first-vetlink.svg',
                    semanticsLabel: 'VetLink Logo',
                    height: 60.0,
                  ),
                  SvgPicture.asset(
                    'assets/logos/logo-second-vetlink.svg',
                    semanticsLabel: 'VetLink Logo',
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).brightness == Brightness.dark
                            ? darkAccentColor
                            : Colors.black,
                        BlendMode.srcIn),
                    height: 60.0,
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
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
                  'Clinic Staffs',
                  style: captionBoldPoppins.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                      padding: const EdgeInsets.only(
                        bottom: 15.0,
                      ),
                      shrinkWrap: true,
                      itemCount: clinicStaffs.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: UniqueKey(),
                          background: Container(
                            color: Colors.red,
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          direction: DismissDirection.endToStart,
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.endToStart) {
                              final result = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Confirm Action'),
                                    content: const Text(
                                      'Are you sure you want to remove the staff account?',
                                    ),
                                    actions: [
                                      TextButton(
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                      ),
                                      ElevatedButton(
                                        child: const Text('Confirm'),
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );

                              return result == true;
                            }
                            return false;
                          },
                          onDismissed: (direction) {
                            clinicStaffs.removeRange(index, index);
                          },
                          child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Image.asset(
                                      clinicStaffs[index]['userRole'] ==
                                              'Veterinarian'
                                          ? 'assets/icons/vet.png'
                                          : 'assets/icons/receptionist.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    '${clinicStaffs[index]['firstName']} ${clinicStaffs[index]['lastName']}',
                                    style: smallRegularPoppins,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
