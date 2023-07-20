import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Homepage")),
          body: Center(
          child: Text("Welcome",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
          )
    );
  }
}
