import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_rentapp/rental_company/vehicleDetail.dart';
import 'package:vehicle_rentapp/rental_company/vehicle_add.dart';
import 'package:vehicle_rentapp/user/login_screen.dart';
import 'package:vehicle_rentapp/user/myaccount_screen.dart';

class Home extends StatelessWidget {
  Home({Key? key, this.email, this.userName}) : super(key: key);
  String? email;
  String? userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text(userName.toString()),
                accountEmail: Text(email.toString())),
            ListTile(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              title: Text("Home"),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyAccount()));
              },
              title: Text("My Account"),
            ),
            ListTile(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              title: Text("SignOut"),
            ),
          ],
        ),
      ),
      appBar: AppBar(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('vehicle').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return GridView.builder(

                itemCount: snapshot.data!.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                    crossAxisSpacing: 2,
                    mainAxisSpacing: 50,
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.yellow[100],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20,bottom: 20),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>VehicleDetails()));
                        },
                        title: Image.network(
                          snapshot.data!.docs[index]['image'],
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                        subtitle: Column(
                          children: [
                            SizedBox(height: 25),
                            Text(snapshot.data!.docs[index]['model']),

                            Text(snapshot.data!.docs[index]['brand'])
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Text("Network error");
          }
        },
      ),
    );
  }
}
