import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondPage extends StatefulWidget {
  SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String? userName;

  String? userAge;

  String? userAddress;

  String? userGender;

  List<String>? userLang = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(width: 200,height: 200, color: Colors.cyan,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            userName == null
                ? Text("No data")
                : Center(child: Text("NAME: $userName",style: TextStyle(fontSize: 15),)),
            SizedBox(height: 10),
            userAge == null
                ? Text("No data")
                : Center(child: Text("AGE: $userAge",style: TextStyle(fontSize: 15),)),
            SizedBox(height: 10),
            userAddress == null
                ? Text("No data")
                : Center(child: Text("ADDRESS: $userAddress",style: TextStyle(fontSize: 15),)),
            SizedBox(height: 10),
            userGender == null
                ? Text("No data")
                : Center(child: Text("GENDER: $userGender",style: TextStyle(fontSize: 15),)),
            SizedBox(height: 10),
            userLang == null
                ? Text("No data")
                : Center(child: Text("LANGUAGES: $userLang",style: TextStyle(fontSize: 15),)),
          ]),
        ),
      ),
    );
  }

  getDetails() async {
    var shredpf = await SharedPreferences.getInstance();
     userName=shredpf.getString('name');
     userAge = shredpf.getString('age');
     userAddress = shredpf.getString('address');
     userGender = shredpf.getString('gender');
     userLang = shredpf.getStringList('lang');
    setState(() {});
  }
}