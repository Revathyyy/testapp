import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class UpdateUser extends StatefulWidget {
  const UpdateUser({super.key});

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final bloodGroups=['A+','A-','B+','B-','O+','O-','AB+','AB-'];
  String? selectedGroup;
   final CollectionReference donor = FirebaseFirestore.instance.collection('donor');
   TextEditingController donorName=TextEditingController();
   TextEditingController donorNumber=TextEditingController();

 void updateDonor(id){
  final data ={
    'name':donorName.text,
    'phone':donorNumber.text,
    'group':selectedGroup
  };
  donor.doc(id).update(data).then((value)=>Navigator.pop(context));
 }
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    donorName.text = args['name'];
    donorNumber.text = args['phone'];
    selectedGroup = args['group'];
    final id = args['id'];
    return Scaffold(
       appBar: AppBar(
        title: Center(child: Text("Update User")),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
               controller: donorName,
              decoration: InputDecoration(
                border:OutlineInputBorder(),
                label:Text("Donor Name") ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: donorNumber,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                border:OutlineInputBorder(),
                label:Text("Phone Number") ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField(
              value: selectedGroup,
              decoration: InputDecoration(
                label: Text("Select Blood Group")
              ),
              items:bloodGroups.map((e)=>DropdownMenuItem(
              child:Text(e),
              value: e,
              )).toList(),onChanged: (val) {
              selectedGroup=val;
            }   
            ,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: (){
            updateDonor(id);
            },
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)),
              backgroundColor: MaterialStateProperty.all(Colors.red),
              foregroundColor:MaterialStateProperty.all(Colors.white) 
            ),
             child: Text("Update",
             style: TextStyle(fontSize: 20),),
            
            ),
          )
        ],
      ),
    );
  }
}