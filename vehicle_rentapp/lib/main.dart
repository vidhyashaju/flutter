import 'package:flutter/material.dart';
import 'package:vehicle_rentapp/user/home_screen.dart';
import 'user/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'rental_company/vehicle_add.dart';
String? userId;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      /*StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            userId=snapshot.data!.uid;
            print(userId);
           return Home();
          }
          else{
            return Login();
          }
        },
      ),*/
    );
  }
}
