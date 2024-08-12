import 'package:flutter/material.dart';

class ViewPetScreen extends StatelessWidget {
  const ViewPetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold (
        appBar: AppBar (
          title: Text('Users Pets', 
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.bold
            ),
           ),
        ),

        body: ListView.builder(
          itemCount: 5, // db  query sum
          itemBuilder: (context, index){
            return Card(
              child: ListTile(
                onTap: () {},
                title: Text('Grey'), // db query select petname
                leading: CircleAvatar(
                  backgroundColor: Colors.blue[400],
                ),
              ),
            );
          }
          ),
        ),
      );
  }
}