import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

String? rentalId;
String? rentalName;
String? year;
String? review;
double rate = 0.0;
String? name;

class VehicleDetails extends StatefulWidget {
  VehicleDetails(
      {Key? key,
      required this.price,
      required this.model,
      required this.image,
      required this.userName,
      required this.email})
      : super(key: key);
  final String? model;
  final String? image;
  final int price;
  String? userName;
  String? email;

  @override
  State<VehicleDetails> createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  getVehicleDetails() async {
    QuerySnapshot vehicleCollection =
        await FirebaseFirestore.instance.collection('vehicle').get();
    print(vehicleCollection);
    vehicleCollection.docs.forEach((element) {
      if (element['model'] == widget.model.toString()) {
        year = element['year'];
        String brand = element['brand'];
        rentalId = element['rental id'];
        print(year);
        print(brand);
        print(rentalId);
      }
    });
  }

  Future<List<QueryDocumentSnapshot<Object?>>> getReview() async {
    CollectionReference bookingRf =
        FirebaseFirestore.instance.collection('booking');
    QuerySnapshot bookingsnap =
        await bookingRf.where('status', isEqualTo: true).where('model',isEqualTo: widget.model).get();
    print(bookingsnap.docs.length);
    return bookingsnap.docs;
  }

  getRentalName() async {
    getReview();
    getVehicleDetails();
    QuerySnapshot rentalCollection =
        await FirebaseFirestore.instance.collection('rental').get();
    rentalCollection.docs.forEach((element) {
      if (element['uid'] == rentalId) {
        rentalName = element['name'];
        print(rentalName);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRentalName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: 400,
              height: 400,
              child: Image.network(widget.image.toString()),
            ),
          ),
          SizedBox(height: 10),
          Text(
            widget.model.toString(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Rs/-${widget.price.toString()}/Day",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Text(
                "Year : ${year.toString()}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            "Rental Company : ${rentalName.toString()}",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ElevatedButton(
              onPressed: () async {
                String uid = FirebaseAuth.instance.currentUser!.uid;
                await FirebaseFirestore.instance
                    .collection('booking')
                    .doc(uid)
                    .set({
                  'uid': uid,
                  'model': widget.model,
                  'year': year,
                  'Rental Company Name': rentalName,
                  'price': widget.price,
                  'image': widget.image,
                  'user name': widget.userName,
                  'user email': widget.email,
                  'status': false,
                });
              },
              child: Text("Book Now",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ))),
          Divider(color: Colors.grey, thickness: 5),
          SizedBox(height: 10),
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Users Reviews:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          SizedBox(height: 10),
          FutureBuilder(
              future: getReview(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasData) {
                 if( snapshot.data!.length==0){
                   return Text("No Reviews Yet",style:TextStyle(fontSize: 20),);
                 }
                 else{
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(
                              snapshot.data![index]['user name'],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              children: [
                                Text(
                                  snapshot.data![index]['review'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RatingBar(
                                        ratingWidget: RatingWidget(
                                            empty: Icon(
                                              Icons.star_border,
                                              color: Colors.yellow,
                                            ),
                                            full: Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                            ),
                                            half: Icon(
                                              Icons.star_half,
                                              color: Colors.yellow,
                                            )),
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        initialRating: snapshot.data![index]['rating'],
                                        direction: Axis.horizontal,
                                        onRatingUpdate: (value) {}),


                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      });}
                } else {
                  return Text("Network Error");
                }
              }),
        ]),
      ),
    );
  }
}
