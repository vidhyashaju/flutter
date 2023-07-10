import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vehicle_rentapp/rental_company/update_vehicledetails.dart';
import 'update_vehicledetails.dart';

class ViewVehicle extends StatelessWidget {
  ViewVehicle({Key? key}) : super(key: key);

  Stream<QuerySnapshot<Map<String, dynamic>>> getVehicleDetails() {
    return  FirebaseFirestore.instance
        .collection('vehicle')
        .where('rental id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Vehicle Details"),),
      body: StreamBuilder(
          stream: getVehicleDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              return GridView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final vehicleId=snapshot.data!.docs[index].id;
                    final image = snapshot.data!.docs[index]['image'];
                    var model = snapshot.data!.docs[index]['model'];
                    var price = snapshot.data!.docs[index]['price'];
                    final category = snapshot.data!.docs[index]['category'];
                    final brand = snapshot.data!.docs[index]['brand'];
                    final year = snapshot.data!.docs[index]['year'];
                    return ListView(shrinkWrap: true, children: [
                      Padding(
                        padding: const EdgeInsets.all(3),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueGrey[200],
                          ),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateVehicleDetails(
                                            image: image,
                                            price: price,
                                            model: model,
                                            brand: brand,
                                            category: category,
                                            year: year,
                                            vehicleId: vehicleId,
                                          )));

                            },
                            title: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.network(
                                snapshot.data!.docs[index]['image'],
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            subtitle: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white70,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(height: 15),
                                  Text(
                                    snapshot.data!.docs[index]['model'],
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    snapshot.data!.docs[index]['price']
                                        .toString(),
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]);
                  });
            } else {
              return Text("Network error");
            }
          }),
    );
  }
}
