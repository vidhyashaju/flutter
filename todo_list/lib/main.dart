import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);

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
List <Map> text=[{'titile':'hai','content':'amma'},
  {'title':'welcome','content':'beena'}
];

TextEditingController textController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:FloatingActionButton(
          backgroundColor: Colors.white70,
          child: Icon(Icons.add,color: Colors.black,size: 30),onPressed: (){
            setState(() {
              text.add({'title':textController.text,'content':textController});});
      }) ,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text("Todo List",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
      backgroundColor: Colors.pinkAccent,
      body: Center(child:

          Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(height: 300,
                width: 300,
                child: ListView.builder(
                  itemCount:text.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    return Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.all(20),
                      color: Colors.white70,

                     child: ListTile(
                          title: Text(text[index]['title']),
                          subtitle: Text(text[index]['content']),
                          leading:Icon(Icons.circle,color: Colors.black) ,
                        ),
                        );

                },),
              ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                decoration: InputDecoration(label: Text("input text here:"),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                controller:textController ,
              ),
            ),
          ],
        ),

          ),

    );
  }
}
