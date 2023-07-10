//Datetime,showtime picker
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
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TimeOfDay? timePic;
  String? datePic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                var tmp = await showTimePicker(
                    context: context, initialTime: TimeOfDay.now());
                setState(() {
                  timePic = tmp;
                });
              },
              child: Container(
                height: 100,
                width: 100,
                child: Image.asset(
                    'assets/clock.jpg'), /*"https://cdn.pixabay.com/photo/2018/03/13/11/26/clock-3222267_960_720.jpg")*/
              ),
            ),
            Text(timePic == null ? "No Time Picked" :"${timePic!.hour}:${timePic!.minute}",
                style: TextStyle(backgroundColor: Colors.cyan, fontSize: 20)),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                var dtp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1990),
                    lastDate: DateTime.now());

                setState(() {
                  datePic = DateFormat('MM/dd/yy').format(dtp!);
                });
              },
              child: Container(
                  height: 100,
                  width: 100,
                  child: Image.network(
                    "https://cdn.pixabay.com/photo/2017/06/10/06/39/calender-2389150_960_720.png",
                    fit: BoxFit.fill,
                  )),
            ),
            SizedBox(height: 20),
            Text(
              datePic == null ? "No Date Picked" : datePic.toString(),
              style:
                  TextStyle(backgroundColor: Colors.greenAccent, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
