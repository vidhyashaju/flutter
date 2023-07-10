import 'package:vehicle_rentapp/rental_company/view_booking.dart';
import 'package:vehicle_rentapp/rental_company/view_review.dart';
import 'view_vehicle.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_rentapp/main.dart';
import 'package:vehicle_rentapp/rental_company/myaccount_rental.dart';
import 'package:vehicle_rentapp/user/login_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'view_review.dart';

class AddVehicles extends StatefulWidget {
  AddVehicles({Key? key, this.email, this.userName}) : super(key: key);
  String? userName;
  String? email;

  @override
  State<AddVehicles> createState() => _AddVehiclesState();
}

class _AddVehiclesState extends State<AddVehicles> {
  List<String> vehicleCategory = ['2 wheeler', '4 wheeler'];

  List<String> brand = [];

  String? selVehCategory;

  String? selVehBrand;
  File? image;
  String? imageUrl;
  TextEditingController model = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController price = TextEditingController();

  getImageCamera() async {
    final ImagePicker picker = ImagePicker();
    XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        image = File(photo.path);
      });
    }
  }

  getImageGallery() async {
    final ImagePicker picker = ImagePicker();
    XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      setState(() {
        image = File(photo.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text(
                  widget.userName.toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                accountEmail: Text(
                  widget.email.toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddVehicles(userName: widget.userName,email: widget.email,)));
              },
              title: Text("Home",
                  style: TextStyle(
                    fontSize: 20,
                  )),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyAccountRent()));
              },
              title: Text(
                "My Account",
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ViewVehicle()));
              },
              title: Text(
                "Update",
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewVehicleBookings()));
              },
              title: Text(
                "View Bookings",
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewMyReviews(
                              userName: widget.userName,
                            )));
              },
              title: Text(
                "View reviews",
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              title: Text(
                "SignOut",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: DropdownButton<String>(
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(10),
                  value: selVehCategory,
                  onChanged: (val) {
                    setState(() {
                      selVehCategory = val;
                      selVehBrand = null;
                      brand = [];
                      if (selVehCategory != null) {
                        if (selVehCategory == '2 wheeler') {
                          brand = [
                            'Yamaha',
                            'Bajaj',
                            'Suzuki',
                            'Honda',
                            'Popular'
                          ];
                        } else {
                          brand = ['Toyota', 'Honda'];
                        }
                      }
                    });
                  },
                  items: vehicleCategory.map((e) {
                    return DropdownMenuItem<String>(value: e, child: Text(e));
                  }).toList(),
                  hint: Text(
                    "category",
                    style: TextStyle(fontSize: 25),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: DropdownButton<String>(
                  borderRadius: BorderRadius.circular(10),
                  isExpanded: true,
                  value: selVehBrand,
                  onChanged: (val) {
                    setState(() {
                      selVehBrand = val;
                    });
                  },
                  items: brand.map((e) {
                    return DropdownMenuItem<String>(value: e, child: Text(e));
                  }).toList(),
                  hint: Text(
                    "brand",
                    style: TextStyle(fontSize: 25),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                style: TextStyle(fontSize: 25),
                controller: model,
                decoration: InputDecoration(
                    hintText: "Model",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                style: TextStyle(fontSize: 25),
                controller: year,
                decoration: InputDecoration(
                    hintText: "Year",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                style: TextStyle(fontSize: 25),
                controller: price,
                decoration: InputDecoration(
                    hintText: "Price",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.grey[600])),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          actions: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  OutlinedButton(
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all(
                                              StadiumBorder())),
                                      onPressed: () {
                                        getImageCamera();
                                        Navigator.pop(context);
                                      },
                                      child: Text("Camera")),
                                  OutlinedButton(
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all(
                                              StadiumBorder())),
                                      onPressed: () {
                                        getImageGallery();
                                        Navigator.pop(context);
                                      },
                                      child: Text("Gallery")),
                                ]),
                          ],
                        );
                      });
                },
                child: Text(
                  "UPLOAD IMAGE",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () async {
                  String imageName = '${DateTime.now()}';
                  Reference ref =
                      FirebaseStorage.instance.ref('image').child(imageName);
                  UploadTask task = ref.putFile(image!);
                  task.whenComplete(() async {
                    imageUrl = await ref.getDownloadURL();
                    await FirebaseFirestore.instance.collection('vehicle').add({
                      'category': selVehCategory,
                      'brand': selVehBrand,
                      'model': model.text,
                      'year': year.text,
                      'price': int.parse(price.text),
                      'image': imageUrl,
                      'rental id': FirebaseAuth.instance.currentUser!.uid,
                    });
                  });
                },
                child: Text(
                  "ADD",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
