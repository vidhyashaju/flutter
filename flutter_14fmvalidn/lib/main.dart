//form validation
import 'package:flutter/material.dart';
void main()
{
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
class HomePage extends StatelessWidget {
    HomePage({Key? key}) : super(key: key);
  String name='',age='',phone='',email='',pwd='';
  var fkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(key:fkey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value)
                    {
                      if(value!.isEmpty)
                        {
                          return"No data found";
                         }
                    },
                    onChanged: (value)
                    {
                      name=value;
                    },

                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius:BorderRadius.circular(10)),
                    label: Text("username"),
                  ),
                  ),
                ),
              ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value)
                      {
                        if(value!.length<8)
                        {
                          return"Pwd too short";
                        }
                      },
                      onChanged: (value)
                      {
                        pwd=value;
                      },

                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius:BorderRadius.circular(10)),
                        label: Text("pwd"),
                      ),
                    ),
                  ),
                ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value)
                    {
                      if(int.parse(value!)>100)
                      {
                        return"Age over";
                      }
                    },
                    onChanged: (value)
                    {
                      age=value;
                    },

                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius:BorderRadius.circular(10)),
                      label: Text("age"),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value)
                    {
                      if(!(value!.contains('@'))&&!(value.contains('.com')))
                      {
                        return"Email not valid";
                      }
                    },
                    onChanged: (value)
                    {
                      email=value;
                    },

                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius:BorderRadius.circular(10)),
                      label: Text("email"),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value)
                      {
                        if((value!.length)<10)
                        {
                          return"Must contain 10 nos";
                        }
                      },
                      onChanged: (value)
                      {
                        phone=value;
                      },

                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius:BorderRadius.circular(10)),
                        label: Text("phone"),
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(onPressed: ()
              {

              }, child: Text("SUBMIT"),),





            ],
          ),
        ),
      ),
    );
  }
}
