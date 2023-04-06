//http post
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
void main()
{
  runApp(MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:HomePage() ,);
  }
}
class HomePage extends StatelessWidget {
   HomePage({Key? key}) : super(key: key);
Future<Map?>getData()async{
 // try{
  String url="https://api.ipify.org/?format=json";
  Response res=await get(Uri.parse(url));
  Map response=jsonDecode(res.body);
  String newIp=response['ip'];
  print(newIp);
  print(response);
  String url1="https://ipinfo.io/$newIp/geo";
  Response res1=await get(Uri.parse(url1));
  Map response1=jsonDecode(res1.body);
  print(response1);
  print(response1.length);
  return response1;
 /* Fluttertoast.showToast(msg: "Success");
  }on Exception catch(error){
    print("error");
    Fluttertoast.showToast(msg: "ERROR");*/
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: getData),
      body: FutureBuilder(
        future: getData(),
          builder: (context,snapshot){
       if( snapshot.connectionState==ConnectionState.waiting)
         {
            return CircularProgressIndicator();
         }
       else if(snapshot.hasData)
         {
           return 
             Card(
               child: Container(child: Column( mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                  Center(child: Text(snapshot.data!['ip']),),
                  Center(child: Text(snapshot.data!['hostname'])),
                  Center(child: Text(snapshot.data!['city'])),
         ],  ),

               ),
             );
           }
       else{
         return Text("Error");
       }
         }
      ),

    );
  }
}


