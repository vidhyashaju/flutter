import 'package:flutter/material.dart';

class Check extends StatefulWidget {
  const Check({Key? key}) : super(key: key);

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  DateTime? datePic;
  TimeOfDay? timePic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 100,
              height: 100,
              color: Colors.redAccent,
              child: GestureDetector(
                onTap: () async {
                  var dt = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1990),
                      lastDate: DateTime.now());
                  setState(() {
                    datePic = dt;
                  });
                  var tm = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(
                          hour: TimeOfDay.minutesPerHour, minute: TimeOfDay.minutesPerHour));
                  setState(() {
                    timePic = tm;
                  });
                },
              )),
          Center(
              child: Text(
                  datePic == null ? "no date picked" : datePic.toString())),
          Center(
              child: Text(
                  timePic == null ? "no date picked" : timePic.toString())),
        ],
      ),
    );
  }
}
