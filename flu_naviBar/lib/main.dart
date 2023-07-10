//Navigation bar 
import 'package:flu_navibar/home_navigation.dart';
import 'package:flu_navibar/settng_navigation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
int selectedIndex=0;

List screen=[Home(),Setting()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[selectedIndex],
      bottomNavigationBar:
          BottomNavigationBar(
              selectedItemColor: Colors.red,
              onTap: (value){
            setState(() {
              selectedIndex=value;
            });
          },
              currentIndex:selectedIndex,
              items: [
            BottomNavigationBarItem(icon:Icon(Icons.home),label: "home"),
            BottomNavigationBarItem(icon:Icon(Icons.settings),label: "settings"),
          ]),
      appBar: AppBar(
        title: Text("Navigation Bar"),
      ),
    );
  }
}
