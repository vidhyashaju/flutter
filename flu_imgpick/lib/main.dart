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
 // File? imageList;
  List<File>? imageList;


  getImage() async {
     ImagePicker _picker = ImagePicker();
     final List<XFile>? photo = await _picker.pickMultiImage();
    if (photo != null) {
        setState(() {
          imageList = photo.map((e) => File(e!.path)).toList();
        });
    }
   // print(imageList!.length);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(floatingActionButton: FloatingActionButton(onPressed: getImage),
      body: SafeArea(
        child: Column(

          children: [
           // FloatingActionButton(onPressed: getImage),
        if(imageList!=null)
                 ListView.builder(shrinkWrap:true ,
                itemCount:imageList!.length,
                itemBuilder:(context,index){
                  if(imageList!=null)
                    {
                   return
                    ListTile(title:Image.file(imageList![index],width: 100,height: 300,));}}

            ),
          ],
        ),
      ),
    );
  }
}
