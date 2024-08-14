import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/main_wrapper.dart';
import 'package:get/get.dart';

class AddPetScreen extends StatelessWidget {
   AddPetScreen({super.key});

  final RxString species = 'Dog'.obs;

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
                     Obx (
                     () => Radio(
                      value: 'Dog',
                      groupValue: species.value,
                      onChanged: (value){
                        species.value = value!;
                      },
                      ),
                     ),
                      SizedBox(width: 10,),
                      Text('Dog'),
                     
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                     Obx (
                     () =>Radio(
                      value: 'Cat',
                      groupValue: species.value,
                      onChanged: (value){
                        species.value = value!;
                      },
                    ),
                     ),
                    SizedBox(width: 10,),
                    Text('Cat'),
                  ],),
                ),
          ],),
           

            Container(
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: TextField(decoration: InputDecoration(
                hintText: 'Pet\'s Name',
                border: OutlineInputBorder()
              ),
              ),
            ),
            Container(
              height: 15
            ),  
            Container(
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: TextField(decoration: InputDecoration(
                hintText: 'Pet\'s Age',
                border: OutlineInputBorder()
              ),
              ),
            ),
            Container(
              height: 15
            ),


             Container(
               decoration: BoxDecoration(color: Colors.grey[300]),
              child: TextField(decoration: InputDecoration(
                hintText: 'Breed',
                border: OutlineInputBorder()
              ),
              ),
            ),
            Container(
              height: 15
            ),  

            Container(

            )
           
          ]
      ),
      ),

        

      fab: FloatingActionButton(
          shape: CircleBorder(),
           backgroundColor: const Color.fromARGB(255, 255, 189, 89), 
          onPressed: () {
            Get.back();
          }),
    );
  }
}
