import 'dart:convert';

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
    return MaterialApp(
      home: SampleHttp(),
    );
  }
}

class SampleHttp extends StatefulWidget {
   SampleHttp({Key? key}) : super(key: key);

  @override
  State<SampleHttp> createState() => _SampleHttpState();
}

class _SampleHttpState extends State<SampleHttp> {
  String result='',res1='',res2='';
  List m=[];

getData()async
{
  String url="https://reqres.in/api/users/2";
  Response res=await get(Uri.parse(url));
  Map response=jsonDecode(res.body);
  print(response);
  setState(() {
    result= response['data']['first_name'];
    res1=response['data']['last_name'];
    res2=response['data']['avatar'];
    print(result);
  });

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(floatingActionButton: FloatingActionButton(onPressed:getData ),
  body: Column(mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Center(child: Text("First name:${result.toString()}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),),
      Center(child: Text("Last name:${res1.toString()}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
      CircleAvatar(child: Image(fit: BoxFit.cover,image: NetworkImage(res2)),),
     /* Container(
      height: 100,
      width: 100,
      decoration:BoxDecoration(image: DecorationImage(image: NetworkImage(res2))),),*/



    ],
  ),

    );
  }
}

