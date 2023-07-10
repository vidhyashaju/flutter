import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home:AnimatedSplashScreen(splash: Container(height: 600,width: 400,
        child: Image.asset('assets/image.jpg')),
            duration: 3500,
            splashTransition:SplashTransition.fadeTransition,
splashIconSize: 600,
            nextScreen:  HomePage()),
       );
  }
}
