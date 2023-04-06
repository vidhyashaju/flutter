import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_rentapp/main.dart';
import 'package:vehicle_rentapp/rental_company/myaccount_rental.dart';
import 'package:vehicle_rentapp/user/login_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
                accountName: Text(widget.userName.toString()),
                accountEmail: Text(widget.email.toString())),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddVehicles()));
              },
              title: Text("Home"),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyAccountRent()));
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
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            icon: Icon(Icons.logout)),
      ]),
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
                            'Hero',
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
                  hint: Text("category")),
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
                  hint: Text("brand")),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
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
                controller: price,
                decoration: InputDecoration(
                    hintText: "Price",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text("UPLOAD IMAGE"),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    OutlinedButton(
                                        onPressed: () {
                                          getImageCamera();
                                        },
                                        child: Text("Camera")),
                                    OutlinedButton(
                                        onPressed: () {
                                          getImageGallery();
                                        },
                                        child: Text("Gallery")),
                                  ]),
                            );
                          });
                    },
                    child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.cyanAccent,
                        alignment: Alignment.topCenter),
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  String imageName = '${DateTime.now()}';
                  Reference ref=FirebaseStorage.instance.ref('image').child(imageName);
                  UploadTask task=ref.putFile(image!);
                  task.whenComplete(()async{
                    imageUrl=await ref.getDownloadURL();
                  await FirebaseFirestore.instance.collection('vehicle').add({
                    'category': selVehCategory,
                    'brand': selVehBrand,
                    'model': model.text,
                    'year': year.text,
                    'price': price.text,
                    'image':imageUrl,
                  });});
                },
                child: Text("ADD"))
          ],
        ),
      ),
    );
  }
}
