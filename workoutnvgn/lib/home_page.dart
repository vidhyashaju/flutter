import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Myhome"),),
      drawer:SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Profile",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold ),),
            CircleAvatar(child: Icon(Icons.person),),
            Text("JOHN"),

          ],
        ),
      )
    );
  }
}


