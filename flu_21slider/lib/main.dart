//slider
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

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
  double valueChanged = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Slider"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
              valueChanged <= 5
                  ? Icons.sentiment_satisfied
                  : Icons.emoji_emotions,
              size: 100,
              color: Colors.yellow),
          SizedBox(height: 20),
          Text(
            valueChanged.toString(),
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Center(
            child: Slider(
              activeColor: Colors.red,
              inactiveColor: Colors.blue,
              thumbColor: Colors.black,
              min: 0,
              max: 10,
              divisions: 5,
              label: "Rating",
              value: valueChanged,
              onChanged: (val) {
                setState(() {
                  valueChanged = val;
                });
              },
            ),
          ),

        ],
      ),
    );
  }
}
