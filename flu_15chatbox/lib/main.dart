import 'package:flu_15chatbox/chatmsgadd.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chatmsgadd.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
String? userId;
String? userName;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);
void getUserId()async
{
  SharedPreferences shredpf=await SharedPreferences.getInstance();
  shredpf.setString('userid', userId!);
  shredpf.setString('name', userName!);
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              userId=snapshot.data!.uid;
              userName=snapshot.data!.email;
              getUserId();
              return Chatmsg();
            }
            else
            {
              return Login();
            }
          }),

    );
  }
}

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  void firebaseSignIn() {
    FirebaseAuth.instance.signInWithEmailAndPassword(email: userName.text, password: pwd.text);
  }

  void firebaseSignUp() {
  FirebaseAuth.instance.createUserWithEmailAndPassword(email: userName.text, password: pwd.text);
  }
  TextEditingController userName = TextEditingController();
  TextEditingController pwd = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
                controller: userName,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)))),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
                controller: pwd,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)))),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: ()async
                  {
                    firebaseSignIn();
                    },
                  child: Text('SignIN')),
              ElevatedButton(
                  onPressed: ()async {
                    firebaseSignUp();
                   },
                  child: Text('SignUp')),],),



        ],
      ),
    );
  }
}
