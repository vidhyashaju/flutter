//Bottom navigation bar playstore app demo
import 'package:flu_23wk/Navigation_books.dart';
import 'package:flu_23wk/content_name.dart';
import 'package:flu_23wk/navigation_listtile.dart';
import 'package:flu_23wk/navigation_game.dart';
import 'package:flutter/material.dart';

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
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  List screen = [NavigationGame(), Books()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Play Store")),
      bottomNavigationBar: BottomNavigationBar(onTap: (value) {
        setState(() {
          selectedIndex = value;
        });
      },
          currentIndex: selectedIndex,
          backgroundColor: Colors.blue,
          iconSize: 30,
          selectedItemColor: Colors.red,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.apps), label: "Apps"),
            BottomNavigationBarItem(icon: Icon(Icons.games), label: "Games"),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: "Books"),
          ]),
      body:    [Column(
      children: [

      Container(height: 200,
      width: 400,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: Content.content.length,
          itemBuilder: (context, index) {
            return Card(margin: EdgeInsets.only(bottom: 70, left: 5, right: 5),
              color: Colors.white10,
              child: SizedBox(width: 130,
                child: ListTile(onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (BuildContext ctx) {
                    return NavigationApp();
                  }));
                },
                  title: Image(
                    fit: BoxFit.fitWidth,
                    image: NetworkImage(
                        Content.content[index]['imgeurl']),
                    width: 100,
                    height: 100,
                  ),

                  subtitle: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(Content.content[index]['title'],
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            );
          }),

    ),
        Container(height: 400,
          width: 400,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Content.content.length,
              itemBuilder: (context, index) {
                return GridView.count(
                    crossAxisCount: 4,
                    children: [
                    ListTile(
                      title: Image(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(
                            Content.content[index]['imgeurl']),
                        width: 100,
                        height: 100,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(Content.content[index]['title'],
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  );
               ]), );
              }),

        ),

      ],
    ),NavigationGame(),Books()][
    selectedIndex
    ]


    );
  }
}
