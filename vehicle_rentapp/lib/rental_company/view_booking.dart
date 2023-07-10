import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewVehicleBookings extends StatelessWidget {
  const ViewVehicleBookings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('booking')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    return ListView.separated(
                        physics: ScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return Divider(thickness: 10);
                        },
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final vehicleId = snapshot.data!.docs[index].id;
                          return Padding(
                            padding: const EdgeInsets.all(2),
                            child: Card(
                              shape: RoundedRectangleBorder(side:BorderSide(width: 2) ,
                                  borderRadius: BorderRadius.circular(25)),
                              borderOnForeground: true,
                              elevation: 5,
                              margin: EdgeInsets.all(25),
                              color: Colors.amber[200],
                              child: ListView(
                                padding: EdgeInsets.all(20),
                                shrinkWrap: true,
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                    "User name: ${snapshot.data!.docs[index]['user name']}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      "User Email: ${snapshot.data!.docs[index]['user email']}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      "Rental Company: ${snapshot.data!.docs[index]['Rental Company Name']}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      "Vehicle Model: ${snapshot.data!.docs[index]['model']}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      "Year: ${snapshot.data!.docs[index]['year']},Price: Rs/- ${snapshot.data!.docs[index]['price']}/Day",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.blue)),
                                          onPressed: () async {
                                            await FirebaseFirestore.instance
                                                .collection('booking')
                                                .doc(vehicleId)
                                                .update({'status': true});
                                          },
                                          child: Text(
                                            "Accept",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          )),
                                      SizedBox(width: 10),
                                      ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.blue),
                                          ),
                                          onPressed: () {},
                                          child: Text(
                                            "Reject",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                    return Text("Error");
                  }
                }),
          ],
        ),
      ),
    );
  }
}
