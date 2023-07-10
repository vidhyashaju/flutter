import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Display extends StatefulWidget {
  Display({Key? key, this.roomno}) : super(key: key);
  String? roomno;

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  final CollectionReference roomRf=FirebaseFirestore.instance.collection('netCash');

  Future<List<QueryDocumentSnapshot<Object?>>> viewDetails(
      String roomNo) async {
    final data = await roomRf
        .where('roomno', isEqualTo: widget.roomno)
        .get();
    return data.docs;
  }

  void deleteRcord(docId){
    setState(() {
      roomRf.doc(docId).delete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [IconButton(onPressed: () {
        exit(0);
      }, icon: Icon(Icons.logout))
      ]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
              future: viewDetails(widget.roomno!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),shape: BoxShape.rectangle,borderRadius: BorderRadius.circular(25)),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            int l=snapshot.data!.length;
                          DocumentSnapshot roomSnap=snapshot.data![index];
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Card(
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                color: Colors.white,
                                child: ListTile(
                                  trailing: IconButton(onPressed: (){
                                    deleteRcord(roomSnap.id);
                                  },icon:Icon(Icons.delete),color: Colors.black),

                                  title: Column(
                                    children: [
                                      Text(
                                        "Amount:${roomSnap['amount']}",
                                        style: TextStyle(color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Date :${roomSnap['dtm']
                                            .toString()}",
                                        style: TextStyle(color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ],

                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  );
                } else {
                  return Text("Error");
                }
              }),
        ],
      ),
    );
  }
}
