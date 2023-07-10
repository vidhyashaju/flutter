import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'view_details.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  List<String> roomNo = ['402', '401', '405', '406','103','Rafeeq'];
  String? selectedRoomNo;
  TextEditingController amtCtlr = TextEditingController();
  TextEditingController dateCtlr = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    amtCtlr.dispose();
  }

  String? datePic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Room No :", style: TextStyle(fontSize: 25)),
                        DropdownButton(
                            borderRadius: BorderRadius.circular(10),
                            value: selectedRoomNo,
                            items: roomNo.map((e) {
                              return DropdownMenuItem<String>(
                                  child:
                                      Text(e, style: TextStyle(fontSize: 25)),
                                  value: e);
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                selectedRoomNo = val!;
                              });
                            }),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: TextFormField(
                          controller: amtCtlr,
                          decoration: InputDecoration(
                              hintText: "Amount",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: TextFormField(
                          onTap: () async {
                            var dtm = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2022),
                                lastDate: DateTime.now());
                            setState(() {
                              datePic = DateFormat('dd/MM/yy').format(dtm!);
                            });
                            dateCtlr.text = datePic!;
                          },
                          controller: dateCtlr,
                          decoration: InputDecoration(
                              hintText: "Date&Time",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white, shape: StadiumBorder()),
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection('netCash')
                                  .add({
                                'roomno': selectedRoomNo,
                                'amount': amtCtlr.text,
                                'dtm': dateCtlr.text,
                              });
                              print(
                                  "room no: $selectedRoomNo, amount : ${amtCtlr.text}  dt: ${dateCtlr.text}");
                              amtCtlr.clear();
                              dateCtlr.clear();
                            },
                            child: Text(
                              "SUBMIT",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            )),
                        SizedBox(width: 10),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white, shape: StadiumBorder()),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewDetails()));
                            },
                            child: Text(
                              "DETAIL VIEW",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            )),
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
