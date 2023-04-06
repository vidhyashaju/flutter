import 'package:flutter/material.dart';
import 'second_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? gender='';
  bool malayalam=false;
  bool english=false;
  List<String>selLang=[];
  List<Map>lang=[{'language':'english','value':false},
    {'language':'malayalam','value':false}
  ];
  TextEditingController name=TextEditingController();
  TextEditingController age=TextEditingController();
  TextEditingController address=TextEditingController();
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(icon: Icon(Icons.logout),onPressed: (){
          Navigator.pop(context);
        }),
      ]),
      body: ListView(

        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: name,
              style: TextStyle(),
              decoration: InputDecoration(hintText: "name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: age,
              style: TextStyle(),
              decoration: InputDecoration(hintText: "age",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(maxLines: 5,
              controller: address,
              style: TextStyle(),
              decoration: InputDecoration(hintText: "Address",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          Row(
            children: [
              SizedBox(width: 30),

              Radio(
                  value:'male', groupValue: gender, onChanged: (val){
                    setState(() {
                      gender=val!;
                    });
              }),
              Text("Male"),
              Radio(
                  value: 'female', groupValue: gender, onChanged: (val){
                    setState(() {
                      gender=val!;
                    });
              }),
              Text("Female"),

            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("Language",style: TextStyle(fontSize: 20),),
            
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Checkbox(value: (english), onChanged: (value){
                  Map m=lang.firstWhere((element) => element['language']=='english');
                  m['value']=true;
                  setState(() {
                    english=value!;
                  });

                  }

                ),
              ),
              Text("Malayalam"),
            ]),
              Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Checkbox(value: (malayalam), onChanged: (value){
                      Map m=lang.firstWhere((element) => element['language']=='malayalam');
                      m['value']=true;
                      setState(() {
                        malayalam=value!;
                      });
                    }),
                  ),
                  Text("English"),
                ],
              ),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed:()async{
                var shredpf=await SharedPreferences.getInstance();
                shredpf.setString('name',name.text);
                shredpf.setString('age', age.text);
                shredpf.setString('address', address.text);
                if(gender=='male')
                  {
                    shredpf.setString('gender', 'Male');
                  }
                else
                  {
                    shredpf.setString('gender', 'Female');
                  }
                lang.forEach((element) {
                  if(element['value']==true)
                    {
                      selLang.add(element['language']);
                    }

                  shredpf.setStringList('lang',selLang);
                });


              }, child: Text("SUBMIT",),

             ),
              SizedBox(width: 10),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SecondPage()));

              }, child: Text("view")),
            ],
          )],
      ),
    );
  }
}
