import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/main_wrapper.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ViewPetScreen extends StatelessWidget {
  ViewPetScreen({super.key});

  final RxString species = 'Dog'.obs;
  final RxString gender = 'Male'.obs;
  final defaultDate = DateTime.now();
  final TextEditingController _dateController = TextEditingController();
  final RxString _selectedDate = ''.obs;

  // final pets = RxList<Map<String, String>>([]);
  final RxList<Map<String, String>> pets = [
    {'name': 'Grey', 'petType': 'Dog', 'age': '6 years', 'breed': 'Aspin'},
    {'name': 'Greya', 'petType': 'Dog', 'age': '5 months', 'breed': 'Aspin'},
    {'name': 'Ally', 'petType': 'Dog', 'age': '1 year', 'breed': 'Aspin'},
    {'name': 'Peewee', 'petType': 'Cat', 'age': '3 months', 'breed': 'Puspin'},
    {'name': 'Pyong-Pyong', 'petType': 'Cat', 'age': '5 years', 'breed': 'Puspin'},
    {'name': 'Pochi', 'petType': 'Dog', 'age': '3 years', 'breed': 'Aspin'},
    {'name': 'Zizi', 'petType': 'Dog', 'age': '1 years', 'breed': 'Aspin'},
    {'name': 'Kilay', 'petType': 'Dog', 'age': '5 months', 'breed': 'Aspin'}
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
              padding: 
             const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              decoration: const BoxDecoration(
                color: Color.fromARGB (255, 12, 192, 223),
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              child: Text(
                'User\'s pets',
                style: TextStyle(
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
              child: Obx(() => ListView.builder(
                itemCount: pets.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Colors.red,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                    ),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (direction) async {
                    return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirm Deletion"),
                            content: Text("Are you sure you want to delete ${pets[index]['name']}?"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(false), // Cancel
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(true), // Confirm
                                child: Text("Delete"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    onDismissed: (direction) {
                      // Perform the delete operation
                      pets.removeAt(index);
                      // Optionally, show a snackbar to indicate successful deletion
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${pets[index]['name']} has been deleted")),
                      );
                    },
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
                                        'Breed: ${pets[index]['breed']}',
                                        style: TextStyle(height: 3),
                                      )
                                    ],
                                  )));
                        },
                        title: Text(pets[index]['name']!),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage( pets[index]['petType'] == 'Dog'
                              ? 'assets/icons/dog.png'
                              : 'assets/icons/cat.jpg',
                        )
                        ),
                      ),
                    );
                  })),
            )
          ],
        ),
      ),
      fab: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Color.fromARGB(255, 255, 189, 89), 
        onPressed: () => _dialogBuilder(context) ,
          // Get.toNamed('/add_pet');

        
        tooltip: 'Add Pet',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
  

 Future<void> _dialogBuilder(BuildContext context) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black45, // The color behind the dialog
    transitionDuration: Duration(milliseconds: 400), // Duration of the transition
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return Center(
        child: AlertDialog(
          title: Text("Add Pet"),
          actions: [
            Row(
              children: [
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Pet\'s Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 15.0),
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Gender',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Breed',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 15.0),
                Flexible(
                  child: Obx(() {
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
                          lastDate: DateTime.now(),
                        );

                        if (pickeddate != null) {
                          _selectedDate.value = DateFormat('yyyy-MM-dd').format(pickeddate);
                        }
                      },
                    );
                  }),
                ),
              ],
            ),
            Container(height: 15),
            Container(height: 15),
            Container(
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                    textStyle: TextStyle(fontSize: 15.0),
                    minimumSize: Size(150, 60),
                  ),
                  child: Text('Add Pet'),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ),
          ],
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      // Customize the transition here (e.g., Slide, Fade, Scale)
      return ScaleTransition(
        scale: CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        ),
        child: child,
      );
    },
  );
}

}
