import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findus/Model/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Profile_screen extends StatefulWidget {
  const Profile_screen({Key? key}) : super(key: key);

  @override
  _Profile_screenState createState() => _Profile_screenState();
}

class _Profile_screenState extends State<Profile_screen> {
  var collection = FirebaseFirestore.instance.collection('FindUsUsers');
  final FirebaseAuth auth = FirebaseAuth.instance;
  Map<String, dynamic>? data;

  getuserdate() async {
    final User user =   auth.currentUser!;
    final uid = user.uid;
    var docSnapshot = await collection.doc(uid).get();
   data = docSnapshot.data();
    print(data.toString());
   nameController.text = data!["name"];
   emialController.text = data!["email"];
    phoneController.text = data!["phone"];
    print('Hello');
    setState(() {

    });
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emialController = TextEditingController();

  void _show() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Updated successfully"),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.teal,
    ));
  }

  void _show2() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Exited from application"),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.redAccent,
    ));
  }

  @override
  void initState() {
    super.initState();
    getuserdate();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.black54, Color.fromRGBO(243, 136, 64, 1.0)]
                )
            ),
            child:  ListView(
              children: <Widget>[


                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Profile',
                      style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),
                    )),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("First name",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(

                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'First Name',
                    ),
                  ),

                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Email ",style: TextStyle(color: Colors.white,fontSize: 20),),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    readOnly: true,
                    controller: emialController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',

                    ),
                    keyboardType:TextInputType.emailAddress,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Phone",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                    ),
                  ),
                ),

                SizedBox(height: 20,),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton.icon(
                      label: Text('Update',
                        style: TextStyle(color: Colors.white
                        ),
                        ),
                      icon: Icon(
                          Icons.edit_rounded,
                          color: Colors.pink,
                          size: 24.0,),
                      onPressed: () {
                        AuthenticationService(FirebaseAuth.instance).updateuser(nameController.text,phoneController.text);
                        _show();



                      },
                    )
                ),
                SizedBox(height: 20,),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton.icon(
                      icon: Icon(
                        Icons.logout,
                        color: Colors.red,
                        size: 24.0,),
                      label: Text('LogOut',style: TextStyle(color: Colors.white),),
                      onPressed: () {
                        AuthenticationService(FirebaseAuth.instance).signOut(context);
                        _show2();

                      },
                    )),
              ],
            ))
        )
      ],
    );
  }
}
