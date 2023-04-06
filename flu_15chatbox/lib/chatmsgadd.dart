import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flu_15chatbox/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

var shredId;

class Chatmsg extends StatelessWidget {
  Chatmsg({Key? key}) : super(key: key);

  TextEditingController user = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                CircleAvatar(
                  child: Icon(Icons.person),
                ),
                SizedBox(width: 10),
                Text('Shravan'),
              ],
            ),
          ),
          centerTitle: true,
          actions: [
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.video_call)),
                IconButton(onPressed: () {}, icon: Icon(Icons.phone)),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
              ],
            ),
          ],
          backgroundColor: Colors.blue,
          leadingWidth: 25,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            icon: Icon(Icons.arrow_back),
          )),
      /* IconButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut();
                SharedPreferences shredpf =
                    await SharedPreferences.getInstance();
                shredpf.remove('userid');
              },
              icon: Icon(Icons.logout)),*/

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: 500,
                child: Showmsg(),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  height: 65,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.emoji_emotions_outlined)),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                              showCursor: true,
                              controller: user,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "  message",
                              )),
                        ),
                      ),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.attach_file)),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.camera_alt)),
                    ],
                  ),
                ),
              ),
              FloatingActionButton(
                elevation: 0,
                backgroundColor: Colors.tealAccent[700],
                onPressed: () {},
                child: IconButton(
                    onPressed: () async {
                      print("hello");
                      FirebaseFirestore.instance
                          .collection('user')
                          .add({'msg': user.text, 'uid': userId});
                      user.clear();
                      SharedPreferences shrdpf =
                      await SharedPreferences.getInstance();
                      shredId = shrdpf.getString('userid');
                      Showmsg();
                    },
                    icon: Icon(Icons.send)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Showmsg extends StatelessWidget {
  Showmsg({Key? key}) : super(key: key);
  DateTime? dt;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('user').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return ListView.builder(
                itemExtent: 80,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  if (shredId == snapshot.data!.docs[index]['uid']) {
                    return ChatBubble(
                      clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 30),
                      backGroundColor: Colors.blue[100],
                      child: Container(
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery
                                  .of(context)
                                  .size
                                  .width * .7),
                          child: Text(style: TextStyle(
                              fontSize: 20,
                              color: Colors.black),
                              '${snapshot.data!.docs[index]['msg']}')),
                    );
                  } else {
                    return ChatBubble(
                      clipper:
                      ChatBubbleClipper1(type: BubbleType.receiverBubble),
                      margin: EdgeInsets.only(top: 20),
                      backGroundColor: Colors.white,
                      alignment: Alignment.topRight,
                      child: Container(
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery
                                  .of(context)
                                  .size
                                  .width * .7),
                          child: Text(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,),
                              '${snapshot.data!.docs[index]['msg']}')),
                    );
                  }
                 });
          } else {
            return Text("Error");
          }
        });
  }
}
