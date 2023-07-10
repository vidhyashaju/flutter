import 'package:firebase_storage/firebase_storage.dart';
import 'package:flu_todonotes/todo_addnote.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoNote(),
    );
  }
}

class TodoNote extends StatefulWidget {
  TodoNote({Key? key}) : super(key: key);

  @override
  State<TodoNote> createState() => _TodoNoteState();
}

class _TodoNoteState extends State<TodoNote> {
  // late QuerySnapshot<Map<String, dynamic>> data;

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      todoNoteView() async {
    final data = await FirebaseFirestore.instance.collection('Notes').get();

    return data.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TodoAddNote()));
                  },
                  child: Text("ADD")),
            ),
            // FutureBuilder(
            //  future: todoNoteView(),

            Expanded(
              child: FutureBuilder(
                  future: todoNoteView(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String im = snapshot.data![index]['image'];
                            return Card(
                              color: Colors.cyan,
                              margin: EdgeInsets.all(10),
                              child: ListTile(
                                title: Text(snapshot.data![index]['titile']),
                                subtitle:
                                    Text(snapshot.data![index]['content']),
                                trailing: Image.network(
                                    snapshot.data![index]['image']),
                              ),
                            );
                          });
                    } else {
                      return Text("Error");
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
