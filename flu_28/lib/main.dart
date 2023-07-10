import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'single_user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListOfUsers(),
    );
  }
}

class ListOfUsers extends StatefulWidget {
  ListOfUsers({Key? key}) : super(key: key);

  @override
  State<ListOfUsers> createState() => _ListOfUsersState();
}

class _ListOfUsersState extends State<ListOfUsers> {
  Map resResponse = {};

  getData() async {
    String url = "https://reqres.in/api/users?page=2";
    Response res = await get(Uri.parse(url));
    Map response = jsonDecode(res.body);
    setState(() {
      resResponse = response;
    });

    print(resResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: getData),
      body: Container(
          child: ListView.builder(
              itemCount: resResponse.length,
              itemBuilder: (BuildContext, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SingleUser(id: resResponse['data'][index]['id'])));
                    },

                    title: Text(resResponse['data'][index]['first_name']),
                  ),
                );
              })),
    );
  }
}
