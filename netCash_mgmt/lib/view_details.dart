import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'display.dart';

class ViewDetails extends StatefulWidget {
  ViewDetails({Key? key}) : super(key: key);

  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  //String? roomNo;
  TextEditingController roomNoCtlr = TextEditingController();

  List<String> roomNo = ['402', '401', '405', '406','103','Rafeeq'];

  String? selectedRoomNo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("SELECT ROOMNO :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                SizedBox(width: 10),
                DropdownButton(borderRadius: BorderRadius.circular(10),
                    value: selectedRoomNo,
                    items: roomNo.map((e){
                      return DropdownMenuItem<String>(child: Text(e,style: TextStyle(fontSize: 20)),value: e);
                    }).toList(),
                    onChanged: (val){
                  setState(() {
                    selectedRoomNo=val!;
                  });
                    }),
              ],
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white,shape: StadiumBorder()),
                onPressed: () {
                 // roomNo = roomNoCtlr.text;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Display(
                                roomno: selectedRoomNo,
                              )));
                },
                child: Text(
                  "VIEW",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black),
                )),
          ],
        ),
      ),
    );
  }
}
