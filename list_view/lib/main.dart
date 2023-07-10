//Listview contact display
import 'package:flutter/material.dart';
import 'package:list_view/contacts.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'contacts.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (ctx){
      return ContactProvider();
    },
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title:Text("Contact"),),
      floatingActionButton:
          FloatingActionButton(child: Text("click"), onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext ctx){
              return Details();
            }));
          }),
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: 300,
              child: ListView.builder(
                itemCount:Provider.of<ContactProvider>(context).name.length,
                itemBuilder: (context, index) {
                  return Card(shadowColor: Colors.black,
                    color: Colors.grey,
                    margin:EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(Provider.of<ContactProvider>(context).name[index]['name']),
                      subtitle: Text(Provider.of<ContactProvider>(context).name[index]['phone']),
                      leading: Icon(Icons.person),
                      trailing: Icon(Icons.search),
                    ),
                  );

                  /*Container( margin: EdgeInsets.all(5),decoration:BoxDecoration(color: Colors.cyan,
                      borderRadius: BorderRadius.circular(10)),

                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                          Icon(Icons.person),
                          Column(mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name[index]['name']),
                              Text(name[index]['phone']),
                            ],
                          ),
                        ],)

                      ],
                    ),
                  );*/
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
