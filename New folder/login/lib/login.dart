import 'package:flutter/material.dart';
import 'package:login/home_page.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();
  TextEditingController pwd = TextEditingController();
  var fmKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.red),
          child: Form(
            key: fmKey,
            child: Column(children: [
              SizedBox(height: 10),
              Center(
                  child: Text(
                "LOGIN FORM",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                    decoration: InputDecoration(hintText: "Email"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email is required";
                      }
                    },
                    controller: email),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                    decoration: InputDecoration(hintText: "Password"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password is required";
                      }
                    },
                    controller: pwd),
              ),
              ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red),
                      shape: MaterialStateProperty.all(StadiumBorder())),
                  onPressed: () {
                    bool val=fmKey.currentState!.validate();
                    if(val==true)
                      {
                        if(email.text=='admin@gmail.com'&& pwd.text=='123456')
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                          }
                      }

                  },
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                  )),
            ]),
          ),
        ),
      ),
    );
  }
}
