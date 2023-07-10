import 'package:flutter/material.dart';
class Details extends StatelessWidget {
   Details({Key? key,this.imgurl,this.title,this.dscption}) : super(key: key);
String? title;
String? imgurl;
String? dscption;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: AppBar(),
      body:Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            leading: Image(image: NetworkImage(imgurl!)),
            title: Text(title.toString()),
            subtitle: Text(dscption.toString()),
          ),
        ],
      ),
    );
  }
}
