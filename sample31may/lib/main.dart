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

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("     Name: "),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(decoration: InputDecoration(border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)))),
                  ),
                ),
              ],
            ),
              DropdownButton(items: items, onChanged: onChanged),
              ElevatedButton(onPressed: (){}, child:Text("go"))

            ]
    )
    ,

    );
  }
}
