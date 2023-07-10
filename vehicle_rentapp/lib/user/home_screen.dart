import 'dart:math';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_rentapp/rental_company/vehicleDetail.dart';
import 'package:vehicle_rentapp/rental_company/vehicle_add.dart';
import 'package:vehicle_rentapp/user/login_screen.dart';
import 'package:vehicle_rentapp/user/my_bookings.dart';
import 'package:vehicle_rentapp/user/myaccount_screen.dart';

class Home extends StatefulWidget {
  Home({Key? key, this.email, this.userName}) : super(key: key);
  String? email;
  String? userName;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> filterOptions = ['category', 'brand', 'none'];
  List<String> categoryList = [];
  String? selectedCategory;
  String? selectedFilterOption;
  bool filterOption = false;
  bool sotOption = false;
  bool isAscending = false;
  bool isDescending = false;
  List<String> sortOption = ['Price(a-z)', 'Price(z-a)'];
  String? selectedSortOption;
  bool category = false;
  List<String> brandList = [];
  bool brand = false;
  String? selectedBrand;

  Future<QuerySnapshot<Map<String, dynamic>>> getFilterList() async {
    QuerySnapshot<Map<String, dynamic>> snap =
        await FirebaseFirestore.instance.collection('vehicle').get();
    snap.docs.forEach((element) {
      if (!categoryList.contains(element.data()['category'])) {
        categoryList.add(element.data()['category']);
      } else if (!brandList.contains(element.data()['brand'])) {
        brandList.add(element.data()['brand']);
      }
    });
    print(snap);
    return snap;
  }

    Future getData() async {
    QuerySnapshot querySnapshot;
    CollectionReference vehicleRf =
        FirebaseFirestore.instance.collection('vehicle');
    querySnapshot = await vehicleRf.get();
    if (category&& selectedCategory != null) {
      querySnapshot =
          await vehicleRf.where('category', isEqualTo: selectedCategory).get();
    } else if (brand && selectedBrand != null) {
      querySnapshot =
          await vehicleRf.where('brand', isEqualTo: selectedBrand).get();
    }
    if (isAscending && selectedSortOption != null) {
      querySnapshot = await vehicleRf.orderBy('price').get();
    } else if (isDescending && selectedSortOption != null) {
      querySnapshot = await vehicleRf.orderBy('price', descending: true).get();
    }
    return querySnapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text(widget.userName.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                accountEmail: Text(widget.email.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))),
            ListTile(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home(userName: widget.userName,email: widget.email,)));
              },
              title: Text("Home",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyAccount()));
              },
              title: Text("My Account",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyBookings(userName:widget.userName ,)));
              },
              title: Text("My Bookings",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
            ),
            ListTile(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              title: Text("SignOut",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
            ),
          ],
        ),
      ),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButton(borderRadius: BorderRadius.circular(10),
                  icon: Icon(Icons.filter_list_alt),
                  hint: Text("FILTER",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  value: selectedFilterOption,
                  items: filterOptions.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e,style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),),
                    );
                  }).toList(),
                  onChanged: (val) {
                    filterOption = true;

                    setState(() {
                      selectedFilterOption = val;
                    });
                    if (val == 'category') {
                      category = true;
                      brand = false;
                      isAscending = false;
                      isDescending = false;
                      getFilterList();
                    } else if (val == 'brand') {
                      brand = true;
                      category = false;
                      isAscending = false;
                      isDescending = false;
                      getFilterList();
                    } else {
                      category = false;
                      brand = false;
                    }
                  },
                ),
                SizedBox(width: 10),
                DropdownButton(borderRadius: BorderRadius.circular(10),
                  icon: Icon(Icons.sort),
                  hint: Text("SORT",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                  value: selectedSortOption,
                  items: sortOption.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e,style: TextStyle(fontSize:20,fontWeight: FontWeight.bold ),),
                    );
                  }).toList(),
                  onChanged: (val) {
                    sotOption = true;
                    print("sorted clicked $sotOption");

                    setState(() {
                      selectedSortOption = val;
                    });
                    category = false;
                    brand = false;

                    if (val == 'Price(a-z)') {
                      isAscending = true;
                      isDescending = false;
                      print("asceding clicked $isAscending");
                    } else {
                      isDescending = true;
                      isAscending = false;
                    }
                  },
                ),
              ],
            ),
            category
                ? SizedBox(
                    height: 40,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Card(
                            clipBehavior: Clip.hardEdge,
                            shape: StadiumBorder(),
                            child: TextButton(
                              child: Text(categoryList[index]),
                              onPressed: () {
                                setState(() {
                                  selectedCategory = categoryList[index];
                                });
                              },
                            ),
                          );
                        }),
                  )
                : SizedBox(
                    height: 40,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: brandList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (brand) {
                            return Card(
                              clipBehavior: Clip.hardEdge,
                              shape: StadiumBorder(),
                              child: TextButton(
                                child: Text(brandList[index]),
                                onPressed: () {
                                  setState(() {
                                    selectedBrand = brandList[index];
                                  });
                                },
                              ),
                            );
                          }
                        }),
                  ),
            SizedBox(height: 40),
            FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  final vehicles = snapshot.data!.docs;
                  return GridView.builder(
                      shrinkWrap: true,
                      itemCount: vehicles.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        final image = vehicles[index]['image'];
                        var model = vehicles[index]['model'];
                        var price = vehicles[index]['price'];
                        return ListView(children: [
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
                                          builder: (context) => VehicleDetails(
                                                //image: image,
                                                model: model,
                                                price: price,
                                                image: image,
                                                email: widget.email,
                                                userName: widget.userName,
                                              )));
                                },
                                title: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.network(
                                    vehicles[index]['image'],
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
                                        vehicles[index]['model'],
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        vehicles[index]['price'].toString(),
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
