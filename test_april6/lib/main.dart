import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
  }
}

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  TextEditingController name = TextEditingController();
  TextEditingController pwd = TextEditingController();
  var fmKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          key: fmKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login Form",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: name,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "User name required";
                    }
                  },
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "user name"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  obscureText: true,
                  validator: (val) {
                    if(val!.length<6){
                    return "Password with min 6 character required";
                  }
                    },
                  controller: pwd,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "password"),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        SharedPreferences shredpf =
                            await SharedPreferences.getInstance();
                        var userName = shredpf.getString('name');
                        var userPwd = shredpf.getString('pwd');
                        if (userName == name.text && userPwd == pwd.text) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        //}
                      }},
                      child: Text(
                        "LOGIN",
                        style: (TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                      )),
                  SizedBox(width: 10),
                  ElevatedButton(
                      onPressed: () async {
                        if(fmKey.currentState!.validate()) {
                          SharedPreferences shredpf =
                          await SharedPreferences.getInstance();
                          shredpf.setString('name', name.text);
                          shredpf.setString('pwd', pwd.text);
                        //  Navigator.push(context, MaterialPageRoute(builder: (
                        //      context) => HomePage()));
                         }},
                      child: Text(
                        "REGISTER",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                ],
              ),

            ],

          ),
        ),
      ),
    );
  }
}
