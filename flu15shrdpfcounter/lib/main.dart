//shredpfrnce with example counter
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  int count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    var shref = await SharedPreferences.getInstance();
    var val = shref.getInt('counter');
    setState(() {
      count = val??0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text("Button pressed $count times")),
            SizedBox(
              height: 20,
            ),
            FloatingActionButton(
              onPressed: () async {
                setState(() {
                  count++;
                });
                var sherf = await SharedPreferences.getInstance();
                sherf.setInt('counter', count);
              },
              child: Icon(Icons.add),
            ),

            FloatingActionButton(
                onPressed: () async {
                  var shref = await SharedPreferences.getInstance();
                 // var val = shref.setInt('counter',0);
                  shref.remove('counter');
                  setState(() {
                    count = 0;
                  });
                },
                child: Text("Reset")),
          ],
        ),
      ),
    );
  }
}
