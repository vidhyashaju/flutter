import 'package:flutter/material.dart';
import 'content.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "sadya",
      home: AnimatedSplashScreen(
        splash: Container(height: 600,width: 100,
          child: Image.asset('assets/sa.jpg',
               fit: BoxFit.fitHeight

            ),
        ),
        nextScreen: HomePage(),
        duration: 3500,
        splashTransition: SplashTransition.rotationTransition,
      ),
    );
  }
}
