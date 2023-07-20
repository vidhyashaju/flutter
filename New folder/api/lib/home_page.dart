import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
class HomePage extends StatefulWidget {
   HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map resNew={};
  getData()async{
    String url="https://reqres.in/api/users?page=2";
    Response res=await get(Uri.parse(url));
    Map response=jsonDecode(res.body);
    setState(() {
      resNew=response;
    });
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: getData,child:Text("clk")),
      body: ListView.builder(
        itemCount:resNew.length ,
          itemBuilder: (context,index){
              return Card(
                child: ListTile(title: Text(resNew['data'][index]['id'].toString()),
                trailing:CircleAvatar(child:Image(image:NetworkImage(resNew['data'][index]['avatar']),)) ,
                subtitle: Column(children: [
                  Text(resNew['data'][index]['first_name']),
                  Text(resNew['data'][index]['last_name']),
                  Text(resNew['data'][index]['email']),
                ]),),
              );

      }),
    );
  }
}
