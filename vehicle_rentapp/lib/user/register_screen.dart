import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_rentapp/main.dart';
import 'package:vehicle_rentapp/user/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();
  TextEditingController pwd = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phone = TextEditingController();
  String errorMessage = '';

  void register(BuildContext context) async {
    try {
      UserCredential userCredential =await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: pwd.text);
      FirebaseFirestore.instance.collection('user').add({
        'uid':userCredential.user!.uid,
        'name': userName.text,
        'email': email.text,
        'password': pwd.text,
        'phone': phone.text,
        'address': address.text
      });
     // Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        errorMessage = "Password provided is too weak";
      } else if (error.code == 'email-already-in-use') {
        errorMessage =
            'The email provided is already registered with another account';
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
    }
  }

  var fmKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: fmKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: userName,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "User Name is Required";
                        }
                      },
                      decoration: InputDecoration(
                          label: Text("User Name"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email is Required";
                      }
                    },
                    controller: email,
                    decoration: InputDecoration(
                        label: Text("Email"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)))),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password is Required";
                      }
                    },
                    controller: pwd,
                    obscureText: true,
                    decoration: InputDecoration(
                        label: Text("Password"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)))),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                    validator: (value) {
                      if (value!.length < 10) {
                        return "Must contains 10 Digits";
                      }
                    },
                    controller: phone,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: InputDecoration(
                        label: Text("Phone No "),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)))),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                    maxLines: 5,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Address is Required";
                      }
                    },
                    controller: address,
                    decoration: InputDecoration(
                        label: Text("Address"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)))),
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (fmKey.currentState!.validate()) {
                      register(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    }
                  },
                  child: Text(
                    "REGISTER",
                    style: TextStyle(fontSize: 20),
                  )),
            ]),
          ),
        ),
      ),
    );
  }
}
