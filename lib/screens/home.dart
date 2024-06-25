import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference donor = FirebaseFirestore.instance.collection('donor');

  void deleteUser(id){
donor.doc(id).delete();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Blood Donation")),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, '/add');
      },
      backgroundColor: Colors.red,
      child: Icon(Icons.add,
      size: 30,
      color: Colors.white,
      ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      body: StreamBuilder(stream:donor.orderBy('name').snapshots(),builder:(context,AsyncSnapshot snapshot){
    if(snapshot.hasData){
return ListView.builder(
  itemCount: snapshot.data!.docs.length,
  itemBuilder:(context,index){
    final DocumentSnapshot donorSnap=snapshot.data!.docs[index];
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(height: 80,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
      color: Colors.white,
      boxShadow: [BoxShadow(
        color: Color.fromARGB(255, 222, 217, 217),
        blurRadius: 10,
        spreadRadius: 15
      )]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 30,
              child: Text(donorSnap['group'],
              style: const TextStyle(fontSize: 25,color: Colors.white),),
              ),
          ),
        ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(donorSnap['name'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          Text(donorSnap['phone'].toString(),style: TextStyle(fontSize: 18),)
        ],
      ),
      Row(children: [
        IconButton(onPressed: (){
          Navigator.pushNamed(context, '/update',arguments: {
            'id':donorSnap.id,
            'name':donorSnap['name'],
            'phone':donorSnap['phone'].toString(),
            'group':donorSnap['group']
          });
        }, icon: Icon(Icons.edit),iconSize: 30,color: Colors.blue,),
        IconButton(onPressed: (){
          deleteUser(donorSnap.id);
        }, icon: Icon(Icons.delete),iconSize: 30,color: Colors.red,)
      
      ],)
      ],),),
    );
    // Text(donorsnap['name']);
  } );
    }
      return Container();
      }, )
    );
  }
}