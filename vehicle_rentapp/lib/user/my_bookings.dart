import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyBookings extends StatefulWidget {
  MyBookings({Key? key,this.userName}) : super(key: key);
String? userName;
  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  Future<List<QueryDocumentSnapshot<Object?>>> getData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? userEmail = user?.email;
    CollectionReference bookingRf =
    await FirebaseFirestore.instance.collection('booking');
    QuerySnapshot snapshot = await bookingRf
        .where('user email', isEqualTo: userEmail)
        .where('status', isEqualTo: true)
        .get();
    return snapshot.docs;
  }

  String msg = '';
  double rate = 0;
  String rentReview = '';
  double rentRate = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    return ListView.separated(
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: Colors.black,
                            thickness: 5,
                            indent: 20,
                            endIndent: 20,
                          );
                        },
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String vehicleId = snapshot.data![index].id;
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Card(
                              margin: EdgeInsets.all(25),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              color: Colors.amber[50],
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    Row(
                                      children: [
                                        Image.network(
                                          snapshot.data![index]['image'],
                                          height: 100,
                                          width: 100,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Model : ${snapshot
                                                  .data![index]['model']}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Year : ${snapshot
                                                  .data![index]['year']}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "Price/Day : ${snapshot
                                                  .data![index]['price']
                                                  .toString()}",
                                              style: TextStyle(fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Row(
                                              children: [
                                                TextButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: RatingBar
                                                                  .builder(
                                                                  itemCount: 5,
                                                                  allowHalfRating: true,
                                                                  direction: Axis
                                                                      .horizontal,
                                                                  itemBuilder: (context,rating){
                                                                    return Icon(Icons.star,color: Colors.amber,);
                                                                  },
                                                                  onRatingUpdate: (rating){
                                                                    print(rating);
                                                                    rentRate=rating;
                                                                  }),
                                                              content: TextFormField(
                                                                onChanged: (val){
                                                                  rentReview=val!;
                                                                  print(rentReview);
                                                                },
                                                                  decoration: InputDecoration(
                                                                      hintText: "Enter ur review here")),
                                                              actions: [
                                                                TextButton(
                                                                    onPressed: () async{
                                                                      await FirebaseFirestore.instance.collection('review').add({
                                                                        'rate':rentRate,
                                                                        'review':rentReview,
                                                                        'username':widget.userName,
                                                                        'rentalName':snapshot.data![index][
                                                                        'Rental Company Name'],
                                                                      });
                                                                      Navigator
                                                                          .pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                        "OK"))
                                                              ],
                                                            );
                                                          });
                                                    },
                                                    child: Text(
                                                      snapshot.data![index][
                                                      'Rental Company Name'],
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    ))
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    RatingBar.builder(
                                        itemCount: 5,
                                        direction: Axis.horizontal,
                                        minRating: 1,
                                        allowHalfRating: true,
                                        itemBuilder: (context, rating) {
                                          return Icon(
                                            Icons.star,
                                            color: Colors.amberAccent,
                                          );
                                        },
                                        //updateOnDrag: true,
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                          rate = rating;
                                        }),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: TextFormField(
                                              onChanged: (val) {
                                                msg = val!;
                                              },
                                              decoration: InputDecoration(
                                                  hintText:
                                                  "Enter ur review here")),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.send),
                                          onPressed: () async {
                                            await FirebaseFirestore.instance
                                                .collection('booking')
                                                .doc(vehicleId)
                                                .update({
                                              'review': msg,
                                              'rating': rate,
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return Text("Network Error");
                  }
                }),
          ],
        ),
      ),
    );
  }
}
