import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  var wt = TextEditingController();
  var ht = TextEditingController();
  var result = '';
  var bgc = Colors.white10;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
              "BMI CALCULATOR")),
      body: Container(
        color: bgc,
        //color: Colors.white10,
        child: Center(
          child: Container(
            width: 300,
            height: 800,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                    "BMI"),
                SizedBox(height: 20),
                TextFormField(
                    keyboardType: TextInputType.number,
                    controller: wt,
                    decoration: InputDecoration(
                      icon: Icon(Icons.monitor_weight_sharp),
                      label: Text("Weight in kg"),
                    )),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: ht,
                  decoration: InputDecoration(
                    icon: (Icon(Icons.height_sharp)),
                    label: Text("Height in cm"),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      var msg = '';
                      var iwt = wt.text.toString();
                      var iht = ht.text.toString();
                      if (iwt != '' && iht != '') {
                        var mht = (int.parse(iht)) / 100;
                        var bmi = ((int.parse(iwt)) / (mht * mht));
                        print(bmi);

                        if (bmi > 25) {
                          bgc = Colors.amberAccent;
                          msg = "YOU ARE OVER WEIGHT !";
                        } else if (bmi < 18) {
                          bgc = Colors.grey;
                          msg = "YOU ARE UNDER WEIGHT ";
                        } else {
                          bgc = Colors.green;
                          msg = "YOU ARE HEALTHY ";
                        }

                        setState(() {
                          result =
                              "$msg \n \n Your BMI is ${bmi.toStringAsFixed(2)}";
                        });

                        print(result);
                      } else {
                        setState(() {
                          result = "Plz fill the required fields";
                        });
                      }
                    },
                    child: Text("CALCULATE")),
                Text(
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.red),
                    result),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
