import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
   HomePage({Key? key}) : super(key: key);
   String data1='';
   String data2='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
         child:
       Container(margin: EdgeInsets.all(10),padding: EdgeInsets.all(20),
         decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
           color: Colors.red,border:Border.all(),
         ),
         child: Center(child:
       Column(mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text("LOGIN",style: TextStyle(
               fontSize: 20,color: Colors.white,fontWeight:FontWeight.bold,
               backgroundColor: Colors.blue,
             ),
             ),
           ),

              Padding(
               padding: const EdgeInsets.all(8.0),
               child: TextField(
                 onChanged: (value){
                   data1=value;
                   //print();
                 },
                 decoration: InputDecoration(label:Text("username"),border:OutlineInputBorder(
                 borderRadius: BorderRadius.circular(10),
               ),

               ),
             ),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextField(
               onChanged: (value){
                 data2=value;
               },decoration: InputDecoration(label:Text("pwd") ,border:OutlineInputBorder(
               borderRadius: BorderRadius.circular(10),
             )
             ),
             ),
           ),
           ElevatedButton(onPressed:(){
            // print(data);
                        if(data1=="abcd" &&data2=="abc")
               {
                 print("Login successfull");
               }
             else
               {
                 print("Login failed");
               }
           }, child: Text("Click")),

         ],
       )),
         height:400 ,
         width: 400,
        // color: Colors.cyan,
       ),),
    );
  }
}
