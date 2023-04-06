import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewNote extends StatefulWidget {
  const ViewNote({Key? key}) : super(key: key);

  @override
  State<ViewNote> createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNote();
  }

  String? getName;
  String? getAge;
  String? getGender;
  List<String>? getLang = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:

         Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getName == null
                  ? Text("No data")
                  : Center(child: Text("NAME : $getName")),
              getAge == null
                  ? Text("No data")
                  : Center(child: Text("AGE : $getAge")),
              getGender == null
                  ? Text("No data")
                  : Center(child: Text("GENDER : $getGender")),
              Text("LANGUAGES : $getLang"),
            ],
          ),


    );
  }

  void getNote() async {
    var shredpf = await SharedPreferences.getInstance();
    getName = shredpf.getString('name');
    getAge = shredpf.getString('age');
    getGender = shredpf.getString('gender');
    getLang = shredpf.getStringList('lang');

    setState(() {});
  }
}
