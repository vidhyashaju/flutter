import 'package:flutter/material.dart';
import 'package:refresh/api_check.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String? name;
  int age = 0;
  String? gender;
  List<String>? lang = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences shredPf = await SharedPreferences.getInstance();
    name = shredPf.getString('name');
    age = shredPf.getInt('age')!;
    gender = shredPf.getString('gender');
    lang = shredPf.getStringList('lang');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Do u want to go back"),
                actions: [
                  TextButton(
                    onPressed: () {
                    },
                    child: Text("YES"),
                  ),
                ],
              );
            });
        return true;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          name == null ? Text("no data") : Text("name : $name"),
          age == null ? Text("no") : Text("age: $age"),
          gender == null ? Text("no") : Text("Gender: $gender"),
          lang == null ? Text("no") : Text("selected langs: $lang"),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Check()));
              },
              child: Text("go")),
        ]),
      ),
    );
  }
}
