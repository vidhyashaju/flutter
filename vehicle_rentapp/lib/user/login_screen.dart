import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_rentapp/main.dart';
import 'package:vehicle_rentapp/rental_company/rental_register.dart';
import 'package:vehicle_rentapp/rental_company/vehicle_add.dart';
import 'package:vehicle_rentapp/user/home_screen.dart';
import 'package:vehicle_rentapp/user/register_screen.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  var fmKey = GlobalKey<FormState>();
  TextEditingController emailCtlr = TextEditingController();
  TextEditingController pwdCtlr = TextEditingController();
  String errorMessage = '';

  void login(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailCtlr.text, password: pwdCtlr.text);
      String uid = userCredential.user!.uid;
      String? email=userCredential.user!.email;
      QuerySnapshot userCollection=await FirebaseFirestore.instance.collection('user').get();
      userCollection.docs.forEach((element) {
        if(element['uid']==uid)
          {
            String userName=element['name'];
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home(email:email,userName: userName,)));
          }
      });
      QuerySnapshot rentalCollection=await FirebaseFirestore.instance.collection('rental').get();
      rentalCollection.docs.forEach((element) {
        if(element['uid']==uid)
        {
          String userName=element['name'];
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddVehicles(userName: userName,email: email,)));

        }
      });

    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        errorMessage = "No user found for that email";
      } else if (error.code == 'wrong-password') {
        errorMessage = 'Wrong password';
      } else if (error.code == 'invalid-email') {
        errorMessage = "Email is badly formatted";
      }
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error Message",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              content: Text(errorMessage,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            );
          });
      emailCtlr.clear();
      pwdCtlr.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/backgrd.jpg'), fit: BoxFit.fill)),
          child:
              //  child:Image.asset('assets/backgd.jpg')),
              Form(
            key: fmKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        style: TextStyle(fontSize: 25, color: Colors.white),
                        "Login")),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                    controller: emailCtlr,
                    style: TextStyle(fontSize: 20, color: Colors.cyan),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "E-mail is required";
                      }
                    },
                    decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.cyanAccent))),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                    controller: pwdCtlr,
                    style: TextStyle(fontSize: 20, color: Colors.cyan),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Password is required";
                      }
                    },
                    decoration: InputDecoration(
                        hintText: "password",
                        hintStyle: TextStyle(color: Colors.cyanAccent))),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.lightBlue[400]),
                      minimumSize: MaterialStateProperty.all(Size(250, 40)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)))),
                  onPressed: () {
                    if (fmKey.currentState!.validate()) {
                      login(context);
                    }
                  },
                  child: Text(
                    "LOGIN",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("New User ?",
                      style: TextStyle(fontSize: 15, color: Colors.cyanAccent)),
                  SizedBox(width: 20),
                  GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                iconColor: Colors.black,
                                actionsAlignment: MainAxisAlignment.center,
                                title: Text("SELECT"),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    OutlinedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.cyanAccent)),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Register()));
                                        },
                                        child: Text(
                                          "USER",
                                          style: TextStyle(color: Colors.black),
                                        )),
                                    SizedBox(width: 25),
                                    OutlinedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.cyanAccent)),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RentalReg()));
                                        },
                                        child: Text(
                                          "RENTAL",
                                          style: TextStyle(color: Colors.black),
                                        )),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(
                                        "OK",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      )),
                                ],
                              );
                            });
                      },
                      child: Text("Register",
                          style: TextStyle(
                              fontSize: 15, color: Colors.cyanAccent))),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
