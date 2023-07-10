import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SingleUser extends StatefulWidget {
   SingleUser({Key? key,this.id}) : super(key: key);
int? id;
  @override
  State<SingleUser> createState() => _SingleUserState();
}

class _SingleUserState extends State<SingleUser> {
  Map? resResponse;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

  }
  getData()async{
  String url="https://reqres.in/api/users/${widget.id}";
  Response res=await get(Uri.parse(url));
  Map response=jsonDecode(res.body);
  print(response);
  setState(() {
    resResponse=response;
  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
      body: Center(child: Text(resResponse==null?"no data":resResponse!['data']['first_name'])),
    );
  }
}
