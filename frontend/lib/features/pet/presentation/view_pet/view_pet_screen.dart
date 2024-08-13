import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/main_wrapper.dart';
import 'package:get/get.dart';

class ViewPetScreen extends StatelessWidget {
  ViewPetScreen({super.key});

  // final pets = RxList<Map<String, String>>([]);
  final RxList<Map<String, String>> pets = [
    {'name': 'Grey', 'petType': 'Dog', 'age': '6 years'},
    {'name': 'Greya', 'petType': 'Dog', 'age': '6 months'},
    {'name': 'Ally', 'petType': 'Dog', 'age': '1 year'},
    {'name': 'Peewee', 'petType': 'Cat', 'age': '3 months'}
  ].obs;

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
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(color: Colors.lightBlue),
              child: Text(
                'User\'s pets',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Expanded(
              child: Obx(() => ListView.builder(
                  itemCount: pets.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                      content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        pets[index]['name']!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                        ),
                                      ),
                                      Text(
                                        'Age: ${pets[index]['age']}',
                                        style: TextStyle(height: 3),
                                      ),
                                      Text(
                                        'Pet Type: ${pets[index]['petType']}',
                                        style: TextStyle(height: 3),
                                      )
                                    ],
                                  )));
                        },
                        title: Text(pets[index]['name']!),
                        leading: CircleAvatar(
                          backgroundColor: pets[index]['petType'] == 'Dog'
                              ? Colors.blueGrey
                              : Colors.greenAccent,
                        ),
                      ),
                    );
                  })),
            )
          ],
        ),
      ),
      fab: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.limeAccent,
        onPressed: () {
          Get.toNamed('/add_pet');
        },
      ),
    );
  }
}
