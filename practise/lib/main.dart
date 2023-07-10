import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List?> getData(String name) async {
    String url = "http://192.168.1.21/crud/API/category_regstr.php";
    Response res = await post(Uri.parse(url),body: {"category_name":name});
   // List response = jsonDecode(res.body);
   // print(response);
   // return response;
  }

  @override

TextEditingController catName=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: catName,
              decoration: InputDecoration(hintText: "category_name",

                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)))),
          ElevatedButton(onPressed: (){
            getData(catName.text);

          }, child: Text("insert")),

          /*FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {},
                          title: Text(snapshot.data![index]['name']),
                        );
                      });
                } else {
                  return Text("Error");
                }
              }),*/
        ],
      ),
    );
  }
}
