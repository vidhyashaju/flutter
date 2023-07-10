import 'package:flu_mar8/homePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp((MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomeScreen();
            } else {
              return LogInPage();
            }
          }),
    );
  }
}

class LogInPage extends StatefulWidget {
  LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  String errmsg='';
  void firebaseSignUp(BuildContext context) async{
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: pwd.text);
    } on FirebaseAuthException catch (error) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error Message"),
              content: Text(error.toString()),
            );
          });
    }
  }

  void firebaseSignIn(BuildContext context) {
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.text, password: pwd.text);
    } on FirebaseAuthException catch (error) {
      setState(() {
        errmsg=error.toString();
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errmsg)));
      /*showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Error Message"),
              title: Text(error.toString()),
            );
          });*/
    }
  }

  Future signInwithGoogle() async {
    final GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleauth =
        await googleuser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleauth?.accessToken,
      idToken: googleauth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  TextEditingController email = TextEditingController();

  TextEditingController pwd = TextEditingController();

  var fmKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: fmKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email address is required";
                    }
                  },
                  controller: email,
                  decoration: InputDecoration(
                      label: Text("user name"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)))),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password is required";
                    }
                  },
                  controller: pwd,
                  decoration: InputDecoration(
                      label: Text("pwd"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)))),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (fmKey.currentState!.validate()) {
                        firebaseSignIn(context);
                      }
                    },
                    child: Text(style: TextStyle(fontSize: 20), "Signin")),
                SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () {
                      if (fmKey.currentState!.validate()) {
                        firebaseSignUp(context);
                      }
                    },
                    child: Text(style: TextStyle(fontSize: 20), "Signup")),
                SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () {
                      signInwithGoogle();
                    },
                    child: Text("Google SignIn")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
