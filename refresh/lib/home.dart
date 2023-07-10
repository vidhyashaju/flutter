import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:refresh/detail.dart';
import 'package:refresh/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? datePic;
  TextEditingController age = TextEditingController();
  TextEditingController cntAge = TextEditingController();
  String gender = '';
  bool mal = false;
  bool eng = false;
  List<Map> lang = [
    {'lang': 'malayalam', 'value': false},
    {'lang': 'english', 'value': false}
  ];
TextEditingController name=TextEditingController();
List<String> selLang=[];
submitData()async{
  await FirebaseFirestore.instance.collection("profile").add({
    'name':name.text,
    'age':cntAge.text,
    'sex':gender,
    'lang':lang,
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(actions: [IconButton(icon: Icon(Icons.logout),onPressed: (){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>Login()));
    },)]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: name,
              decoration: InputDecoration(
                  hintText: "username",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(StadiumBorder()),
            ),
            child: Icon(
              Icons.calendar_month_sharp,
            ),
            onPressed: () async {
              var dtp = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime.now());
              setState(() {
                datePic = DateFormat('dd/MM/yy').format(dtp!);
              });
              age.text = datePic.toString();
              var currentAge = DateTime.now().year - dtp!.year;
              print(currentAge);
              cntAge.text = currentAge.toString();
            },
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(right: 200, left: 10),
            child: TextFormField(
              controller: age,
              decoration: InputDecoration(
                  hintText: "age",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(right: 200, left: 10),
            child: TextFormField(
              controller: cntAge,
              decoration: InputDecoration(
                  hintText: "age",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          Row(
            children: [
              Radio(
                  value: 'male',
                  groupValue: gender,
                  onChanged: (val) {
                    setState(() {
                      gender = val!;
                    });
                  }),
              Text("Male"),
            ],
          ),
          Row(
            children: [
              Radio(
                  value: 'female',
                  groupValue: gender,
                  onChanged: (val) {
                    setState(() {
                      gender = val!;
                    });
                  }),
              Text("Female"),
            ],
          ),
          Text("Languages"),
          Row(
            children: [
              Checkbox(
                  value: (eng),
                  onChanged: (val) {
                    Map m = lang
                        .firstWhere((element) => element['lang'] == 'english');
                    m['value'] = true;
                    setState(() {
                      eng = val!;
                    });
                  }),
              Text("English"),
            ],
          ),
          Row(
            children: [
              Checkbox(
                  value: (mal),
                  onChanged: (val) {
                    Map m = lang.firstWhere(
                        (element) => element['lang'] == 'malayalam');
                    m['value'] = true;
                    setState(() {
                      mal = val!;
                    });
                  }),
              Text("Malayalam"),
            ],
          ),
          ElevatedButton(onPressed: ()async{
            submitData();
            SharedPreferences shredpf=await SharedPreferences.getInstance();
            shredpf.setString('name', name.text);
            shredpf.setInt('age',int.parse(cntAge.text));
            if(gender=='male'){
            shredpf.setString('gender', 'Male');}
            else
              {
                shredpf.setString('gender','Female');
              }
            lang.forEach((element) {
              if(element['value']==true){
                selLang.add(element['lang']);
              }
              shredpf.setStringList('lang', selLang);
            });
            Navigator.push(context,MaterialPageRoute(builder: (context)=>Details()));
          }, child: Text("submit")),
        ],
      ),
    );
  }
}
