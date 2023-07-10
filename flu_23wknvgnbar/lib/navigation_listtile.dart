import 'package:flutter/material.dart';

class NavigationApp extends StatelessWidget {
  const NavigationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listtile"),
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: 200,
            child: Center(child: Text("IKEA")),
            color: Colors.cyan,
          ),
          SizedBox(height: 10),
          Container(
            height: 200,
            width: 200,
            child: Center(child: Text("AMAZON")),
            color: Colors.orange,
          ),
          SizedBox(height: 10),
          Container(
            height: 200,
            width: 200,
            child: Center(child: Text("H & M")),
            color: Colors.greenAccent,
          ),
        ],
      )),
    );
  }
}
