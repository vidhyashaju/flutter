import 'package:flutter/material.dart';
import 'package:refresh/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,

      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
        if(snapshot.hasData){
          return Home();
        }
        else
          {
            return Login();
          }
      }),
    );
  }
}

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
void firebaseSignup(BuildContext context)async{
await FirebaseAuth.instance.createUserWithEmailAndPassword(email: name.text, password: pwd.text);
}
void firebaseSignin(BuildContext context)async{
  await FirebaseAuth.instance.signInWithEmailAndPassword(email: name.text, password: pwd.text);
}
  TextEditingController name = TextEditingController();

  TextEditingController pwd = TextEditingController();

  var fmKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: fmKey,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.cyan),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "username required";
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "username",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        controller: name),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "pwd required";
                          }
                        },

                        decoration: InputDecoration(
                            hintText: "password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        controller: pwd),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                if (fmKey.currentState!.validate()) {
                                 /* SharedPreferences shredPf =
                                      await SharedPreferences.getInstance();
                                  shredPf.setString('name', name.text);
                                  shredPf.setString('pwd', pwd.text);*/
                                  firebaseSignup(context);
                                }
                              },
                              child: Text("Signup")),
                          ElevatedButton(
                              onPressed: () async{
                                /*SharedPreferences shredPf=await SharedPreferences.getInstance();
                                var userName=shredPf.getString('name');
                                var userPwd=shredPf.get('pwd');
                                print(userName);
                                if(userName==name.text&&userPwd==pwd.text)
                                  {
                                    Fluttertoast.showToast(msg: "Login success");
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                                  }
                                else{
                                  Fluttertoast.showToast(msg: "Login failed",timeInSecForIosWeb: 5);
                                }*/
                                firebaseSignin(context);
                              }, child: Text("Signin")),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
