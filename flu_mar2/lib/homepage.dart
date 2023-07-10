//use of Future builder
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'first_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<Map?> getData() async {
    try {
      String url = "https://dog.ceo/api/breeds/image/random";
      Response res = await get(Uri.parse(url));
      Map response = jsonDecode(res.body);
      print(response);
      return response;
    } on Exception catch (error) {
      Fluttertoast.showToast(msg: "Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
          });
        },
      ),
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              return Container(
                  height: double.infinity,
                  width: double.infinity,
                  margin: EdgeInsets.all(10),
                  child: Image(
                    image: NetworkImage(snapshot.data!['message']),
                  ));
            } else {
              return Text("Network issue");
            }
          }),
    );
  }
}
