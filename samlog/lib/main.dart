//flutter toast
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  String user='';
  String pwd='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(),
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(10)),
          width: 350,
          height: 300,
          margin: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment:CrossAxisAlignment.center,
              children: [
                Center(

                    child: Text(
                      "Login Form",
                      style: TextStyle(
                        wordSpacing: 2,
                        height: 2,
                        //backgroundColor: Colors.white,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),


                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    onChanged: (value){
                        user=value;
                  },
                    showCursor: true,
                    decoration: InputDecoration(
                        label: Text("user name"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(onChanged: (value){
                    pwd=value;
                  },
                    showCursor: true,
                    decoration: InputDecoration(
                        label: Text("pwd"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                ElevatedButton(
                    onPressed: ()
                {

                  if( user=="anu" && pwd=="abc")
                    {
                      print("Login successful");
                      Fluttertoast.showToast(msg:"Success");
                    }
                  else
                    {
                      print("Login failed");
                      Fluttertoast.showToast(msg:"Fail",toastLength: Toast.LENGTH_LONG,backgroundColor: Colors.redAccent,);
                    }
                }, child:const Text("SUBMIT")),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
