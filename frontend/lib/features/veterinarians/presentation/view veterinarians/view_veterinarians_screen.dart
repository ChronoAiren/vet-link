import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/main_wrapper.dart';
import 'package:get/get.dart';

class ViewVeterinariansScreen extends StatelessWidget {
  // ViewVeterinariansScreen({super.key, String? message});
  
  ViewVeterinariansScreen({super.key, required this.selectedClinic});

  final RxList<Map<String, String>> veterinarians = [
    {
      'clinicName': 'Pet Care', 
      'Veterinarian': 'Shaman Doe', 
      'contactNumber' : '12365459876',
      'daySchedule' : 'Mon-Wed',
      'time' : '9:00AM - 1:00pm',
      'address' : 'Arellano St. Tagum City'
    },
    {
      'clinicName': 'Pet Care', 
      'Veterinarian': 'Allysha Des',
      'contactNumber' : '09635459876',
      'daySchedule' : 'Mon, Wed, Fri',
      'time' : '10:00AM - 3:00pm',
      'address' : 'Arellano St. Tagum City'
    },
    {
      'clinicName': 'Best Buddies', 
      'Veterinarian': 'Mc Vee Delos Santos',
      'contactNumber' : '09061432754',
      'daySchedule' : 'Mon-Fri',
      'time' : '9:00AM - 4:00pm',
      'address' : 'Bonifacio St. Tagum City'
    },
    {
      'clinicName': 'Best Buddies', 
      'Veterinarian': 'Haru Zab',
      'contactNumber' : '09758757055',
      'daySchedule' : 'Tue & Thu',
      'time' : '8:00AM - 1:00pm',
      'address' : 'Bonifacio St. Tagum City'
    },
    {
      'clinicName': 'Animal Care',
      'Veterinarian': 'Zabuza Ses',
      'contactNumber' : '78965454123',
      'daySchedule' : 'Wed -Fri',
      'time' : '9:00AM - 3:00pm',
      'address' : 'Rizal St. Tagum City'
    },
    {
      'clinicName': 'Animal Care', 
      'Veterinarian': 'Alien Dam',
      'contactNumber' : '45635285466',
      'daySchedule' : 'Mon-Fri',
      'time' : '9:00AM - 2:00pm',
      'address' : 'Rizal St. Tagum City'
    },
  ].obs;

  final RxString selectedClinic ;

  @override
  Widget build(BuildContext context) {
    return MainWrapper(
      content: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 12, 192, 223),
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              child:  Text(
                'Veterinarians in $selectedClinic Clinic ' ,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: veterinarians.length,
                  itemBuilder: (context, index) {
                    if (veterinarians[index]['clinicName'] ==
                        selectedClinic.value) {
                      return ListTile(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    veterinarians[index]['Veterinarian']!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 35,
                                    ),
                                  ),
                                  Text(   
                                    veterinarians[index]['daySchedule']!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(   
                                    veterinarians[index]['time']!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(   
                                    veterinarians[index]['contactNumber']!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(   
                                    veterinarians[index]['address']!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  ElevatedButton(
                                    onPressed: (){
                                    //   Navigator.push(context,
                                    //  MaterialPageRoute(builder: (context) => SetAppointment(()),
                                    }, 
                                    child: const Text('Set Appointment')
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        title: Text(veterinarians[index]['Veterinarian']!),
                      );
                    } else {
                      
                      return const SizedBox.shrink();
                    }
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
