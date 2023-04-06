import 'package:flutter/material.dart';
import 'package:list_view/contacts.dart';
import 'package:list_view/main.dart';
import 'package:provider/provider.dart';
class Details extends StatelessWidget {
   Details({Key? key}) : super(key: key);
  TextEditingController nameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  Map m={};


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
      body:
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration:InputDecoration(
                      label: Text("username"),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(keyboardType: TextInputType.number,
                    controller: phoneController,
                    decoration: InputDecoration(
                      label: Text("phone"),
                      border:OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(onPressed: (){
                   Provider.of<ContactProvider>(context,listen: false).name.add({'name':nameController.text,'phone':phoneController.text});
                   //print(Contact.name);
                   Navigator.push(context, MaterialPageRoute(builder: (BuildContext ctx){
                     return HomePage();
                   }));
                  }, child: Text("ADD")),
                ],
              ),
            ),
    );
  }
}
