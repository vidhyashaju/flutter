import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicle_rentapp/rental_company/vehicle_add.dart';
import 'package:vehicle_rentapp/rental_company/view_vehicle.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UpdateVehicleDetails extends StatefulWidget {
  UpdateVehicleDetails({Key? key,
    this.category,
    this.price,
    this.image,
    this.year,
    this.model,
    this.brand,
    this.vehicleId})
      : super(key: key);
  String? category;
  String? model;
  String? brand;
  int? price;
  String? year;
  String? image;
  String? vehicleId;

  @override
  State<UpdateVehicleDetails> createState() => _UpdateVehicleDetailsState();
}

class _UpdateVehicleDetailsState extends State<UpdateVehicleDetails> {
  TextEditingController categoryController = TextEditingController();

  TextEditingController brandController = TextEditingController();

  TextEditingController modelController = TextEditingController();

  TextEditingController yearController = TextEditingController();

  TextEditingController priceController = TextEditingController();
  File? image;
  String? imageUrl;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    getVehicleDetails();
  }

  getVehicleDetails() {
    categoryController.text = widget.category!;
    brandController.text = widget.brand!;
    modelController.text = widget.model!;
    yearController.text = widget.year!;
    priceController.text = widget.price!.toString();
  }

  storeImage() async {
    String imageName = '${DateTime.now()}';
    Reference ref = FirebaseStorage.instance.ref('image').child(imageName);
    UploadTask task = ref.putFile(image!);
    task.whenComplete(() async {
      imageUrl = await ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('vehicle')
          .doc(widget.vehicleId)
          .update({
        'image': imageUrl,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                  controller: categoryController,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      label: Text(
                        "Category",
                        style: TextStyle(fontSize: 20),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)))),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                  controller: brandController,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      label: Text("Brand", style: TextStyle(fontSize: 20)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)))),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                  controller: modelController,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      label: Text("Model", style: TextStyle(fontSize: 20)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)))),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                  controller: yearController,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      label: Text("Year", style: TextStyle(fontSize: 20)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)))),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                  controller: priceController,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      label: Text("Price", style: TextStyle(fontSize: 20)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)))),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: 100,
                    child: Image.network(widget.image!),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ElevatedButton(
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
                                            // Navigator.pop(context);
                                          },
                                          child: Text("Camera")),
                                      OutlinedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all(
                                                  StadiumBorder())),
                                          onPressed: () {
                                            getImageGallery();
                                            //Navigator.pop(context);
                                          },
                                          child: Text("Gallery")),
                                    ],
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        storeImage();
                                        Navigator.pop(context);
                                      },
                                      child: Text("OK")),
                                ],
                              );
                            });
                      },
                      child: Text("Upload Photo",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.grey[600]))),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              ElevatedButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('vehicle')
                      .doc(widget.vehicleId)
                      .update({
                    'category': categoryController.text,
                    'brand': brandController.text,
                    'model': modelController.text,
                    'year': yearController.text,
                    'price': int.parse(priceController.text),
                  });
                  Navigator.pushAndRemoveUntil(
                      context, MaterialPageRoute(builder: (context)=>AddVehicles()), (
                      route) => false);
                },
                child: Text(
                  "UPDATE",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('vehicle')
                        .doc(widget.vehicleId)
                        .delete();
                  },
                  child: Text(
                    "DELETE",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ))
            ]),
          ],
        ),
      ),
    );
  }
}
