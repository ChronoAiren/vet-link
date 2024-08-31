import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/main_wrapper.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddPetScreen extends StatelessWidget {
  AddPetScreen({super.key});

  final RxString species = 'Dog'.obs;
  final RxString gender = 'Male'.obs;
  final defaultDate = DateTime.now();
  final TextEditingController _dateController = TextEditingController();
  final RxString _selectedDate = ''.obs;

//   final RxList <String> dogBreeds = [
//     'Aspin',
//     'Golden Retriever ',
//     'Bulldog',
//     'Shih Tzu',
//     'Chihuahua',
//     'Siberian Husky'

//   ].obs;

// final RxList <String> catBreeds = [
//     'Puspin',
//     'Persian ',
//     'Maine Coon',
//     'Siamese',
//     'Sphynx',
//     'Bengal'

//   ].obs;
//   final RxString catValue = 'Puspin'.obs;
//   final RxString dogValue = 'Aspin'.obs;
//   final RxString defaultValue = 'Aspin'.obs;

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
                  'Add Pet',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Obx(
                          () => Radio(
                            value: 'Dog',
                            groupValue: species.value,
                            onChanged: (value) {
                              species.value = value!;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Dog'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Obx(
                          () => Radio(
                            value: 'Cat',
                            groupValue: species.value,
                            onChanged: (value) {
                              species.value = value!;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Cat'),
                      ],
                    ),
                  ),
                ],
              ),

              // Row(
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.all(10.0),
              //         child: Row(

              //           children: [
              //            Obx (
              //            () => Radio(
              //             value: 'Male',
              //             groupValue: gender.value,
              //             onChanged: (value){
              //               gender.value = value!;
              //             },
              //             ),
              //            ),
              //             SizedBox(width: 10,),
              //             Text('Male'),

              //           ],
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.all(10.0),
              //         child: Row(
              //           children: [
              //            Obx (
              //            () =>Radio(
              //             value: 'Female',
              //             groupValue: gender.value,
              //             onChanged: (value){
              //               gender.value = value!;
              //             },
              //           ),
              //            ),
              //           SizedBox(width: 10,),
              //           Text('Female'),
              //         ],),
              //       ),
              // ],),

              Row(
                children: [
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Pet\'s Name',
                          border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Gender', border: OutlineInputBorder()),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),

              Row(
                children: [
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Breed', border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Flexible(
                    child: Obx(() {
                      // Update the text field with the value of _selectedDate
                      _dateController.text = _selectedDate.value;
                      return TextField(
                          controller: _dateController,
                          decoration: InputDecoration(
                            labelText: 'Birthdate',
                          ),
                          onTap: () async {
                            DateTime? pickeddate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now());

                            if (pickeddate != null) {
                              _selectedDate.value =
                                  DateFormat('yyyy-MM-dd').format(pickeddate);
                            }
                          });
                    }),
                  ),
                ],
              ),

              Container(height: 15),

              Container(height: 15),

              Container(
                child: ElevatedButton(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  child: Text('Add Pet'),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ]),
      ),
    );
  }
}
