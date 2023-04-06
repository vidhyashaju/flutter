import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flu_todonotes/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TodoAddNote extends StatefulWidget {
  TodoAddNote({Key? key}) : super(key: key);

  @override
  State<TodoAddNote> createState() => _TodoAddNoteState();
}

class _TodoAddNoteState extends State<TodoAddNote> {
  TextEditingController title = TextEditingController();

  TextEditingController content = TextEditingController();
  String? imageUrl;
  File? image;

  getImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        image = File(photo.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ToDoNotes")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
                controller: title,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)))),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
                controller: content,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)))),
          ),
          GestureDetector(
              onTap: () async {
                getImage();
                              },
              child: Container(
                height: 100,
                width: 100,
                color: Colors.cyan,
              )),
          SizedBox(height: 10),
          ElevatedButton(
              onPressed: ()async{
                String imageName ='${DateTime.now()}';
                Reference ref =
                FirebaseStorage.instance.ref('image').child(imageName);
                UploadTask task= ref.putFile(image!);
                task.whenComplete(()async {
                imageUrl = await ref.getDownloadURL();
                FirebaseFirestore.instance.collection('Notes').add({
                  'titile': title.text,
                  'content': content.text,
                  'image': imageUrl
                });});
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TodoNote()));

              },
              child: Text("SUBMIT"))
        ],
      ),
    );
  }
}
