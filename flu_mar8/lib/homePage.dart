import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: (){
          FirebaseAuth.instance.signOut();
          GoogleSignIn().signOut();
        }, icon: Icon(Icons.logout)),
      ]),
      body:StreamBuilder(
        stream: Stream.periodic(Duration(seconds: 1)),
        builder: (context, snapshot) {
          return Center(child: Text('${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}'));
        }
      ),

    );
  }
}
