import 'package:flutter/material.dart';

class Logout extends StatelessWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title:Text("Logout"),actions: [Icon(Icons.logout)],centerTitle: true),

    );
  }
}
