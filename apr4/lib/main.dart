import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  List name = ['vidhya', 'shaju', 'shravan', 'shrika'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(height: double.infinity,
              width: double.infinity,
              child: GridView.count(
                crossAxisCount: 1,
                children: [
                  ListView.separated(
                      separatorBuilder:(context,index){
                        return Divider();
                      } ,
                    shrinkWrap: true,
                      itemCount: name.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                        return ListView(scrollDirection: Axis.vertical,
                          shrinkWrap: true,

                          children: [
                           Card(margin: EdgeInsets.all(20),
                             color: Colors.green,
                            child: Center(child: Text(name[index])),),],
                        );
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
