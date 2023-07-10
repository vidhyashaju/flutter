import 'package:flutter/material.dart';
import 'package:flutter_diffnavgn/homepage.dart';
import 'package:http/http.dart';
import 'first_page.dart';
import 'homepage.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main()
{
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(home: HomePage(),
      );
  }
}
