//Listview display items
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
  List<String> items = [];
  String name = '';
  var fmKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(key: fmKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height:200,
                width: 300,
                child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return (Container(margin: EdgeInsets.only(left:50,right: 50),
                        decoration: BoxDecoration(
                            color: Colors.cyan,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all()),
                        height: 50,
                        width: 50,
                        child: Center(child: Text(items[index])),
                      ));
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty)
                      {
                        return "Data not found";
                      }
                  },
                  decoration: InputDecoration(
                      label: Text("Add items here:"),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 5),
                          borderRadius: BorderRadius.circular(10))),
                  onChanged: (value) {
                    name = value;
                    print(value);
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    bool val=fmKey.currentState!.validate();
                    if(val==true){
                    setState(() {
                      items.add(name);

                    });}
                    print(items);
                  },
                  child: Text("ADD",style: TextStyle(fontSize: 20,
                      fontWeight:FontWeight.bold),)),
            ],
          ),
        ),
      ),
    );
  }
}
