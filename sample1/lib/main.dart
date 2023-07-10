import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  String? datepic;

  TimeOfDay? timepic;
  int selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedindex,
          onTap: (v) {
            setState(() {
              selectedindex = v;
            });
          },
          items: [
            BottomNavigationBarItem(label: "home", icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: "search", icon: Icon(Icons.search)),
          ]),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: GestureDetector(
            onTap: () async {
              var dt = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1990),
                  lastDate: DateTime.now());
              var tm = await showTimePicker(
                  context: context, initialTime: TimeOfDay.now());
              setState(() {
                datepic = DateFormat('MM/dd/yy').format(dt!);
                timepic = tm;
              });
              print(datepic);
            },
            child: Container(
              height: 100,
              width: 100,
              color: Colors.cyan,
            ),
          ),
        ),
        SizedBox(height: 10),
        Center(child: Text(datepic == null ? "no date" : datepic.toString())),
        Center(child: Text(timepic == null ? "no date" :" ${timepic!.hour}:${timepic!.minute}")),
      ]),
    );
  }
}
