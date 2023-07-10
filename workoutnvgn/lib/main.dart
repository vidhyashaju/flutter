//navigation
import 'package:flutter/material.dart';
import 'package:workout/first_page.dart';
import 'home_page.dart';
void main()
{
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(
      ),
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  List screen=[Welcome(),Logout()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          selectedItemColor: Colors.redAccent,
          onTap: (value) {
            setState(() {
              selectedIndex=value;
            });
          },
          items: [
            BottomNavigationBarItem(icon:Icon(Icons.home),label: "Home",backgroundColor: Colors.cyan),
            BottomNavigationBarItem(
                icon: Icon(Icons.logout),
                label: "Logout",
                backgroundColor: Colors.red)
          ]),
      body: screen[selectedIndex],);
  }
}

