import 'package:findus/Model/authentication_service.dart';
import 'package:findus/Screen/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class foregetpassword extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();

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

                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child:Image.asset('assets/images/findusicon.png'),width: 200,height: 150,),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Forget Password',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Please enter the Email here',
                      style: TextStyle(fontSize: 15),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Email to Forget Password ',
                    ),
                  ),
                ),

                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(

                      child: Text('Reset Password'),
                      onPressed: () {
                        if (emailController.text.isEmpty){
                          AuthenticationService(FirebaseAuth.instance).showAlertDialog(context,"Please Enter Email ");
                        }else {
                          AuthenticationService(FirebaseAuth.instance)
                              .resetPassword(emailController.text, context);


                        }
                      },
                    )),
              ],
            )));
  }

}
