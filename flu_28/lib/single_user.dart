import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SingleUser extends StatefulWidget {
  SingleUser({super.key, required this.id});

  int id;

  @override
  State<SingleUser> createState() => _SingleUserState();
}

class _SingleUserState extends State<SingleUser> {
  Map? resResponse;

  getData() async {
    String url = "https://reqres.in/api/users/${widget.id}";
    Response res = await get(Uri.parse(url));
    Map response = jsonDecode(res.body);
    setState(() {
      resResponse = response;
    });

    print(resResponse);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListTile(
              tileColor: Colors.cyan,
        title: Text(resResponse == null
              ? "no data"
              : resResponse!['data']['first_name']),
        subtitle: Text(resResponse == null
              ? "no data"
              : resResponse!['data']['last_name']),
              trailing:Image(image:NetworkImage(resResponse!['data']['avatar'])),
      ),
          )),
    );
  }
}
