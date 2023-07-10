import 'package:flutter/material.dart';
import 'home_page.dart';
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
  TextEditingController nameController = TextEditingController();

  TextEditingController ageController = TextEditingController();

  String gender = '';

  bool mal = false;

  bool eng = false;
  List<String> m = [];
  List<Map> languages = [
    {'language': 'english', 'value': false},
    {'language': 'malayalam', 'value': false}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Container(width: 300,
            child: ListView(
              children: [
                SizedBox(height: 40),
                TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        label: Text("name"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)))),
                SizedBox(height: 20),
                TextFormField(
                  controller: ageController,
                  decoration: InputDecoration(
                      label: Text("age"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Gender:       "),
                    Radio(
                        value: 'male',
                        groupValue: gender,
                        onChanged: (v) {
                          setState(() {
                            gender = v!;
                          });
                        }),
                    Text("Male"),
                    Radio(
                        value: 'female',
                        groupValue: gender,
                        onChanged: (v) {
                          setState(() {
                            gender = v!;
                          });
                        }),
                    Text("Female"),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text("Languages:"),
                    Checkbox(
                        value: eng,
                        onChanged: (v) {
                          Map m = languages
                              .firstWhere((e) => e['language'] == 'english');
                          m['value'] = true;
                          setState(() {
                            eng = v!;
                          });
                          Text("English");
                        }),
                    Text("English"),
                    Checkbox(
                        value: mal,
                        onChanged: (v) {
                          Map m = languages
                              .firstWhere((e) => e['language'] == 'malayalam');
                          m['value'] = true;
                          setState(() {
                            mal = v!;
                          });
                        }),
                    Text("Malayalam"),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () async {
                      var shredpf = await SharedPreferences.getInstance();
                      shredpf.setString('name', nameController.text);
                      shredpf.setString('age', ageController.text);
                      if (gender == 'male') {
                        shredpf.setString('gender', 'male');
                      } else {
                        shredpf.setString('gender', 'female');
                      }
                      languages.forEach((element) {
                        if (element['value'] == true) {
                          m.add(element['language']);
                        }
                      });
                      shredpf.setStringList('lang', m);
                    },
                    child: Text("save")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ViewNote();
                      }));
                    },
                    child: Text("view")),
              ],
            ),
          ),
        ),

    );
  }
}
