
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
File? image;

  getImage()async{
    final ImagePicker _pick=ImagePicker();
     XFile? photo=await _pick.pickImage(source: ImageSource.camera);
    if(photo!=null)
      {
         setState(() {
           image= File(photo.path);
         });
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:

       Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
         children: [

        if(image!=null)Image.file(image!),


       FloatingActionButton(onPressed:getImage),],),),
      );


  }
}
