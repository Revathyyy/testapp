import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:testapp/screens/home.dart';

import './screens/add.dart';
import './screens/update.dart';
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // Platform.isAndroid?
  await Firebase.initializeApp(
    options:const FirebaseOptions(apiKey: "AIzaSyCJd7Eb7bnN6KUqdJhBHifRLhA0si_t8yw",
    appId: "1:1045663445130:android:333fb42103082a2ee5bd73",
    messagingSenderId: "1045663445130",
     projectId: "donorapp-40a2b")
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/':(context)=>HomePage(),
        '/add':(context)=>AddUser(),
        '/update':(context)=>UpdateUser(),
      },
      initialRoute: '/',
      
    );
  }
}


