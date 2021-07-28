

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findus/Screen/Desktop.dart';
import 'package:findus/Screen/Login.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'dart:convert';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {

  final FirebaseAuth _firebaseAuth;
  final DBRef = FirebaseFirestore.instance.collection('FindUsUsers');
  final DBRe = FirebaseFirestore.instance.collection('climelocation');
  AuthenticationService(this._firebaseAuth);

  /// Changed to idTokenChanges as it updates depending on more cases.
 // Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  /// This won't pop routes so you could do something like
  /// Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  /// after you called this method if you want to pop all routes.
  Future<void> signOut(context) async {
    await _firebaseAuth.signOut();
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("password", "");
    pref.setString("email", "");

    Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) => Login_scrren()),);
  }

  Future<FirebaseAuth> getCurrentAuth() async {
    return _firebaseAuth;
  }

  Future<String?> resetPassword(String email, BuildContext ctx) async {
    print("password reset");
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      showAlertDialog(ctx, "email is sent for reset Password");

      return "Signed in";
    } on FirebaseException catch (e) {
      showAlertDialog(ctx, e.message!);
      print(e.message);
      return e.message;
    }
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String?> signIn(
      {required String email,
      required String password,
      BuildContext? ctx}) async {
    try {
      UserCredential userCredential =
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

       if (userCredential.user!.uid.isNotEmpty){
         saveData(email: email, password: password);

         Navigator.pushReplacement(ctx!,
           MaterialPageRoute(
               builder: (context) => Home_screen()),);
       }

      return "Signed in";
    } on FirebaseException catch (e) {
      showAlertDialog(ctx!, "Email and Password inVaild");
      print(e.message);
      return e.message;
    }
  }

  saveData({String? password, String? email}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("password", password!);
    pref.setString("email", email!);
  }
  

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String?> signUp(
      {required String email,
      required String password,
      required String name,
        required bool allow,
        required String phone,
        BuildContext? ctx}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      DBRef.doc(FirebaseAuth.instance.currentUser!.uid) .set({


        'email' : email,
        'name' :name,
        'password': password,
        'phone' : phone,
        'allow' : allow
      });
      //creae the user in the database
      saveData(email: email, password: password);

      Navigator.pushReplacement(ctx!,
        MaterialPageRoute(
            builder: (context) => Home_screen()),);
      
       //sendMailVerification(_firebaseAuth);

      return "Signed up";
    } on FirebaseException catch (e) {
      showAlertDialog(ctx!, e.message.toString());
      print(e.message);
      return e.message;
    }
  }

  showAlertDialog(BuildContext context, String mess) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text(mess),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  updateuser(String email,String name,String Phone){
    DBRef.doc(FirebaseAuth.instance.currentUser!.uid).update({


      'email' : email,
      'name' :name,
      'phone' : Phone,


    });
  }

  sendMailVerification(FirebaseAuth currentAuth, BuildContext? ctx) {
    try {
      currentAuth.currentUser!.sendEmailVerification();
      showAlertDialog(ctx!, "Please check your Email");
    } catch (e) {
      print("An error occured while trying to send email verification");
      // print(e.message);
    }
  }
  Updatedloaction(String id,String Location,String Image) async
  {
    var result =  await DBRe.add({
      'id' : id,
      'loaction': Location,
      'image' : Image,
    });
    return result.id;


  }
}
