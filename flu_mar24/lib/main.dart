import 'package:flutter/material.dart';
void main()
{
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home:Home(),

    );
  }
}
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(body:
      GestureDetector(onTap: (){
        showDialog(context: context, builder: (context){
          return AlertDialog(title: Text("hai"),);
        });
      },
          child: Container(width:100,height: 100,color: Colors.brown,)),

    );
  }
}
