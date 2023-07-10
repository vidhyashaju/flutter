//currency converter
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

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  TextEditingController inrController = TextEditingController();
  TextEditingController usdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          width: 300,
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                onChanged: (val){
                  double inddou = double.parse(inrController.text);
                  double res = inddou / 82.73;
                  usdController.text = res.toString();
                                  },

                controller: inrController,
                decoration: InputDecoration(
                    suffixIcon: IconButton(onPressed: (){
                      inrController.clear();
                    },icon: Icon(Icons.clear),),
                    label: Text("Indian rupee"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
              SizedBox(height: 20),
              TextFormField(
                onChanged: (val){
                  double usddou=double.parse(usdController.text);
                  double res=usddou*82.73;
                  inrController.text=res.toString();
                },
                controller: usdController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(onPressed: (){
                    usdController.clear();},icon: Icon(Icons.clear),
                  ),
                    label: Text("USD"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
              ElevatedButton(
                  onPressed: () {
                    double indInt = double.parse(inrController.text);
                    double res = indInt / 82.73;
                    usdController.text = res.toString();
                  },
                  child: Text("Convert")),
            ],
          ),
        ),
      ),
    );
  }
}
