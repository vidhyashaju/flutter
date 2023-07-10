import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ViewMyReviews extends StatelessWidget {
  ViewMyReviews({Key? key, this.userName}) : super(key: key);
  String? userName;

  Future<List<QueryDocumentSnapshot<Object?>>> getReview() async {
    print(userName);
    CollectionReference reviewRf =
        FirebaseFirestore.instance.collection('review');
    QuerySnapshot reviewSnap =
        await reviewRf.where('rentalName', isEqualTo: userName).get();
    return reviewSnap.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
              future: getReview(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        print(snapshot.data!.length);
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            color: Colors.greenAccent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10,),side: BorderSide(width: 1)),
                            child: ListTile(
                              title: Text(
                                snapshot.data![index]['username'],
                                style: TextStyle(fontSize: 25),
                              ),
                              subtitle: Column(
                                children: [
                                  RatingBar(
                                      itemCount: 5,
                                      direction: Axis.horizontal,
                                      initialRating: snapshot.data![index]
                                          ['rate'],
                                      allowHalfRating: true,
                                      ratingWidget: RatingWidget(
                                        half: Icon(
                                          Icons.star_half,
                                          color: Colors.amber,
                                        ),
                                        full: Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        empty: Icon(
                                          Icons.star_border,
                                          color: Colors.amber,
                                        ),
                                      ),
                                      onRatingUpdate: (rating) {}),
                                  Text(
                                    snapshot.data![index]['review'],
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ],
                              ),
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
    );
  }
}
