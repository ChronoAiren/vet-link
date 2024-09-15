import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/main_wrapper.dart';
import 'package:frontend/styles/dark_theme.dart';
import 'package:frontend/styles/light_theme.dart';
import 'package:get/get.dart';


class ViewVeterinarianScreen extends StatelessWidget {
  // const ViewVeterinarianScreen({super.key});
  
  ViewVeterinarianScreen({super.key, required this.selectedVeterinarian});

  final RxList<Map<String, String>> veterinarianInfo = [
   {
      'clinicName': 'Pet Care', 
      'Veterinarian': 'Shaman Doe', 
      'contactNumber' : '12365459876',
      'daySchedule' : 'Mon-Wed-Fri',
      'time' : '9:00AM - 1:00pm',
      'address' : 'Arellano St. Tagum City',
      'gender' : 'Male',
      
    },
    {
      'clinicName': 'Pet Care', 
      'Veterinarian': 'Allysha Des',
      'contactNumber' : '09635459876',
      'daySchedule' : 'Tue & Thu',
      'time' : '10:00AM - 3:00pm',
      'address' : 'Arellano St. Tagum City',
      'gender' : 'Female'
    },
    {
      'clinicName': 'Best Buddies', 
      'Veterinarian': 'Mc Vee Delos Santos',
      'contactNumber' : '09061432754',
      'daySchedule' : 'Mon-Wed-Fri',
      'time' : '9:00AM - 4:00pm',
      'address' : 'Bonifacio St. Tagum City',
      'gender' : 'Male'
    },
    {
      'clinicName': 'Best Buddies', 
      'Veterinarian': 'Haru Zab',
      'contactNumber' : '09758757055',
      'daySchedule' : 'Tue & Thu',
      'time' : '8:00AM - 1:00pm',
      'address' : 'Bonifacio St. Tagum City',
      'gender' : 'Male'
    },
    {
      'clinicName': 'Animal Care',
      'Veterinarian': 'Zabuza Ses',
      'contactNumber' : '78965454123',
      'daySchedule' : 'Mon-Wed-Fri',
      'time' : '9:00AM - 3:00pm',
      'address' : 'Rizal St. Tagum City',
      'gender' : 'Male'
    },
    {
      'clinicName': 'Animal Care', 
      'Veterinarian': 'Alien Dam',
      'contactNumber' : '45635285466',
      'daySchedule' : 'Tue & Thu',
      'time' : '9:00AM - 2:00pm',
      'address' : 'Rizal St. Tagum City',
      'gender' : 'Female'
    },
  ].obs;
  
  final RxString selectedVeterinarian;

  @override
  Widget build(BuildContext context) {
    return MainWrapper(
      content: SizedBox(
          height:MediaQuery.of(context).size.height ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding :
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                  ),
                child: Obx(() =>
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(223, 223, 223, 210),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Dr. $selectedVeterinarian',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                )
                )
              )
            ],
          ),
      ),
    );
  }
}