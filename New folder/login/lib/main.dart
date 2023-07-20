import 'package:flutter/material.dart';
import 'package:login/login.dart';
import 'package:login/home_page.dart';
void main()
{
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(home: Login(),
    debugShowCheckedModeBanner: false,);
  }
}



