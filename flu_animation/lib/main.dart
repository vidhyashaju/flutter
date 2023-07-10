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
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Color currentColour = Colors.blue;
  var val='';
  TextEditingController msg= TextEditingController();
DateTime dt=DateTime.now();
String? frtime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Container(
            height: 80,
            child: Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(controller: msg,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: "message",
                            border: InputBorder.none),
                        onChanged: (v){
                          setState(() {
                            v='y';
                            val=v;
                         //   msg.clear();
                          });}
                        ),
                  ),
                ),
          (val=='y')?CircleAvatar(child: IconButton(onPressed: (){
            msg.clear();

          },icon: Icon(Icons.send)),):
          CircleAvatar(
                  child: IconButton(
                      onPressed: () {}, icon: Icon(Icons.keyboard_voice_sharp)),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Center(
              child: GestureDetector(
            onTap: () {
              if (currentColour == Colors.blue) {
                setState(() {
                  currentColour = Colors.red;
                });
              } else {
                currentColour = Colors.blue;
              }
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 10),
              height: 200,
              width: 200,
              color: currentColour,
            ),
          )),
        ],
      ),
    );
  }
}
