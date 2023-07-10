//Datetime pic with image
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
  DateTime? datePic;
  TimeOfDay? timePic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              color: Colors.yellowAccent,
              child: GestureDetector(
                onTap: () async {
                  var timeP = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  setState(() {
                    timePic = timeP;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Center(
                child: Text(style: TextStyle(backgroundColor:Colors.yellowAccent,fontSize: 20 ),
                   timePic == null ? "No time picked" : timePic.toString())),

            SizedBox(height: 20),
            Container(decoration:BoxDecoration(
                shape: BoxShape.circle,
              color: Colors.cyanAccent  ),
              height: 100,
              width: 100,
             // color: Colors.cyan,,
              child: GestureDetector(
                  onTap: () async {
                var date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1990),
                    lastDate: DateTime.now());
                setState(() {
                  datePic = date;
                });
                print(datePic);
              }),
            ),
            SizedBox(height: 20),
            Center(
                child: Text(style: TextStyle(fontSize:20 ,
                    backgroundColor: Colors.cyan),
                    datePic == null ? "No date picked" : datePic.toString())),
          ],
        ),
      ),
    );
  }
}
