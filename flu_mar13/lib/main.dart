import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Clock(),
    );
  }
}

class Clock extends StatefulWidget {
  Clock({Key? key}) : super(key: key);

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  List fruits = ['apple', 'orange'];

  DateTime? datepic;
  var age;
TextEditingController agecontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(enabled: true,
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                controller:agecontroller ),
          ),
          StreamBuilder(
            stream: Stream.periodic(Duration(seconds: 1)),
            builder: (context, snapshot) {
              return Center(
                child: Text(
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                    '${DateTime
                        .now()
                        .hour}:${DateTime
                        .now()
                        .minute}:${DateTime
                        .now()
                        .second}'),
              );
            },
          ),
          ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      AlertDialog(
                        backgroundColor: Colors.cyanAccent,
                        title: Text("Alert Dialog Box Opened"),
                        content: Text("Do u want to close"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Yes")),
                          TextButton(onPressed: () {}, child: Text("No")),

                        ],
                      ),
                );
              },
              child: Text("Show Alert Dialog Box")),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(30),
            child: DropdownButtonFormField(
                borderRadius: BorderRadius.zero,
                items: fruits.map((e) {
                  return DropdownMenuItem(
                      value: e,
                      child: Text(e));
                }).toList(), onChanged: (val) {}),
          ),
          FloatingActionButton(onPressed: () async {
            var dtp=await showDatePicker(context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now());
            setState(() {
              datepic=dtp;
            });
            var res=datepic!.year;
            age=DateTime.now().year-res;
            agecontroller.text=age.toString();
            print(age);
          }),

        ],
      ),
    );
  }
}
