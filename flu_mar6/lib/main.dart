import 'package:location/location.dart';
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
  Location location = Location();

  LocationData? _locationData;
  var _locData;

  getLocation() async {
    _locData = await location.getLocation();
    setState(() {
      _locationData = _locData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: FloatingActionButton(onPressed: getLocation)),
          SizedBox(height: 10),
          Center(
              child: Text(
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan),
                  _locationData == null
                      ? "null"
                      : _locationData!.latitude.toString())),
        ],
      ),
    );
  }
}
