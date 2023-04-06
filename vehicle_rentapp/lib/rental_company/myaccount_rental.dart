import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyAccountRent extends StatefulWidget {
   MyAccountRent({Key? key}) : super(key: key);

  @override
  State<MyAccountRent> createState() => _MyAccountRentState();
}

class _MyAccountRentState extends State<MyAccountRent> {
  TextEditingController email = TextEditingController();

  TextEditingController pwd = TextEditingController();

  TextEditingController userName = TextEditingController();

  TextEditingController address = TextEditingController();

  TextEditingController phone = TextEditingController();

  var fmKey = GlobalKey<FormState>();

  Future<QuerySnapshot<Map<String, dynamic>>> getUser() async {
    final data = await FirebaseFirestore.instance
        .collection('rental')
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    var name = data.docs!.toList();
    print(name);
    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("MyAccount")),
        body: Container(
          child: SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              FutureBuilder(
                  future: getUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentsnap =
                          snapshot.data!.docs[index];
                          userName.text = documentsnap['name'];
                          pwd.text = documentsnap['password'];
                          email.text = documentsnap['email'];
                          phone.text = documentsnap['phone'];
                          address.text = documentsnap['address'];
                          return Form(key: fmKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: TextFormField(
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "User name is  required";
                                        }
                                      },
                                      controller: userName,
                                      decoration: InputDecoration(
                                          label: Text("User Name"),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(10)))),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: TextFormField(
                                      validator: (val) {
                                        if (val!.length < 10) {
                                          return "Must contains 10 digits";
                                        }
                                      },
                                      maxLength: 10,
                                      controller: phone,
                                      decoration: InputDecoration(
                                          label: Text("Phone No "),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(10)))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: TextFormField(
                                      maxLines: 5,
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "Address is required";
                                        }
                                      },
                                      controller: address,
                                      decoration: InputDecoration(
                                          label: Text("Address"),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(10)))),
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      if(fmKey.currentState!.validate()){
                                      await FirebaseFirestore.instance
                                          .collection('rental')
                                          .doc(documentsnap.id)
                                          .update({
                                        'name': userName.text,
                                        'phone': phone.text,
                                        'address': address.text
                                      });
                                      Navigator.pop(context);
                                    }},
                                    child: Text(
                                      "UPDATE",
                                      style: TextStyle(fontSize: 20),
                                    )),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Text(("error"));
                    }
                  }),
            ]),
          ),
        ),

      );
  }
}
