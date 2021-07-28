import 'package:findus/Model/authentication_service.dart';
import 'package:findus/Screen/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Theme.dart';
import 'Desktop.dart';
class Singup_screen extends StatefulWidget {
  const Singup_screen({Key? key}) : super(key: key);

  @override
  _Singup_screenState createState() => _Singup_screenState();
}

class _Singup_screenState extends State<Singup_screen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emialController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

          appBar: AppBar(
            title: Center(child: Text('Missing Child',style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),)),
                ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                // Container(
                //     alignment: Alignment.center,
                //     padding: EdgeInsets.all(10),
                //     child: Text(
                //       'Find Us',
                //       style: TextStyle(
                //           color: MyColors.primaryColorLight,
                //           fontWeight: FontWeight.w500,
                //           fontSize: 30),
                //     )),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child:Image.asset('assets/images/findusicon.png'),width: 200,height: 150,),

                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: emialController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',

                    ),
                    keyboardType:TextInputType.emailAddress,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(

                    controller: phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(

                      child: Text('Register'),
                      onPressed: () {
                        if(nameController.text.isEmpty){
                          AuthenticationService(FirebaseAuth.instance).showAlertDialog(context,"Please Enter Name");

                        }else
                        if(emialController.text.isEmpty){
                          AuthenticationService(FirebaseAuth.instance).showAlertDialog(context,"Please Enter a Valid Email");
                        }else if (passwordController.text.isEmpty){
                          AuthenticationService(FirebaseAuth.instance).showAlertDialog(context,"Please Enter Password");
                        }else if (phoneController.text.isEmpty){
                          AuthenticationService(FirebaseAuth.instance).showAlertDialog(context,"Please Enter Phone Number");
                        }else  {
                          AuthenticationService(FirebaseAuth.instance).signUp(
                            ctx: context,
                              allow: true,
                              email: emialController.text,
                              password: passwordController.text,
                              name: nameController.text,
                              phone: phoneController.text);


                        }
                        },
                    )),
                Container(
                    child: Row(
                      children: <Widget>[
                        Text('Already have an account?'),
                        FlatButton(
                          textColor: MyColors.primaryColor,
                          child: Text(
                            'Sign In',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            //signup screen
                            Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Login_scrren()),);
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ))
              ],
            )
        ));
  }
}
