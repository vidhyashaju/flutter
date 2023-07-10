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
  Map resNew = {};
  getData() async {
    String url = "https://reqres.in/api/users?page=2";
    Response res = await get(Uri.parse(url));
    Map response = jsonDecode(res.body);
    print(response);

    setState(() {
      resNew = response;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: Text("Click"),
          onPressed: getData),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 160,
              height: 600,
              child: ListView.builder(
                  itemCount: resNew.length,
                  itemBuilder: (Buildcontext, index) {
                    return Card(
                      margin: EdgeInsets.all(2),
                      borderOnForeground: true,
                      color: Colors.black,
                      child: ListTile(
                        textColor: Colors.red,
                        tileColor: Colors.cyanAccent,
                        title: Text(resNew['data'][index]['first_name'],
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          resNew['data'][index]['last_name'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        leading: CircleAvatar(
                            child: Image(
                          image: NetworkImage(resNew['data'][index]['avatar']),
                        )),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
