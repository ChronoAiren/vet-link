import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/main_wrapper.dart';
import 'package:get/get.dart';


class ViewClinicsScreen extends StatelessWidget {
   ViewClinicsScreen({super.key});

  final RxList<Map<String, String>> clinics =[
    {'clinic' : 'Pet Care', 'location' : 'Tagum City'},
    {'clinic' : 'Pets Best', 'location': 'Tagum City'},
    {'clinic' : 'Best Buddies', 'location' : 'Davao City'},
    {'clinic' : 'Animal Care', 'location' : 'Davao City'}
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
                'Clinics',
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
              itemCount: clinics.length,
              itemBuilder: (context, index){
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.red,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white 
                    ),
                    alignment:  Alignment.center,
                    padding: EdgeInsets.all(20),
                  ),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) async{
                    return await showDialog(
                      context: context, 
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Confirm Deletion"),
                          content: Text ("Are you sure you want to delete ${clinics[index]['clinic']}?"),
                          actions: <Widget>[ 
                            TextButton(
                              onPressed: () => Navigator.of(context)
                                      .pop(false),
                                  child: Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context)
                                      .pop(true),
                                  child: Text("Delete"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onDismissed: (direction) {
                        // Perform the delete operation
                        clinics.removeAt(index);
                        // Optionally, show a snackbar to indicate successful deletion
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  "${clinics[index]['clinic']} has been deleted")
                                ),
                        );
                      },
                 child: ListTile(
                  onTap: (){
                    showDialog(
                      context: context, 
                      builder: (context) => AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(clinics[index]['clinic']!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                            ), 
                            ),
                          ],
                        )
                      )
                    );
                  },
                 )
                 );
              },
              )
            )
          )
          ] 
            ), 
      ),
    );
    
  }
} 