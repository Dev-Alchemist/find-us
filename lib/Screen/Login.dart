import 'package:findus/Model/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Theme.dart';
import 'Desktop.dart';
import 'ForgetPassword.dart';
import 'SignUp.dart';
class Login_scrren extends StatelessWidget {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Missing Child', style: TextStyle(fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold),)),
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
                //
                //           fontSize: 30),
                //     )),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Image.asset('assets/images/findusicon.png'),
                  width: 200,
                  height: 150,),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter you email',
                    ),
                    keyboardType: TextInputType.emailAddress,
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
                FlatButton(
                  onPressed: () {
                    //forgot password screen
                    Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => foregetpassword()),);
                  },
                  textColor: MyColors.primaryColorLight,
                  child: Text('Forgot Password'),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(

                      child: Text('Login'),
                      onPressed: () {
                        print(nameController.text);
                        print(passwordController.text);
                        if (nameController.text.isEmpty) {
                          AuthenticationService(FirebaseAuth.instance)
                              .showAlertDialog(context, "Please Enter Email");
                        } else if (passwordController.text.isEmpty) {
                          AuthenticationService(FirebaseAuth.instance)
                              .showAlertDialog(
                              context, "Please Enter Password");
                        } else {
                          AuthenticationService(FirebaseAuth.instance).signIn(
                              ctx: context,
                              email: nameController.text,
                              password: passwordController.text) ;


                        }
                      },
                    )),
                Container(
                    child: Row(
                      children: <Widget>[
                        Text('Dont have an account?'),
                        FlatButton(
                          textColor: MyColors.primaryColor,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) =>
                                    Singup_screen()),);
                            },
                            child: Text(
                              'Register here',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          onPressed: () {
                            //signup screen
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ))
              ],
            )));
  }
  }

