import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:findus/Screen/Desktop.dart';
import 'package:findus/Screen/Login.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final DBRef = FirebaseFirestore.instance.collection('FindUsUsers');
  final DBRe = FirebaseFirestore.instance.collection('Sighted');
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

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login_scrren()),
    );
  }

  Future<FirebaseAuth> getCurrentAuth() async {
    return _firebaseAuth;
  }

  Future<String?> resetPassword(String email, BuildContext ctx) async {
    print("password reset");
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      showAlertDialog(ctx, "Email sent for reset password");

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
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user!.uid.isNotEmpty) {
        DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
            .instance
            .collection("FindUsUsers")
            .doc(userCredential.user!.uid)
            .get();

        if (doc.id.isNotEmpty) {
          if (doc['allow'] == true) {
            saveData(email: email, password: password);

            Navigator.pushReplacement(
              ctx!,
              MaterialPageRoute(builder: (context) => Home_screen()),
            );
          }else{
      showAlertDialog(ctx!, "Your account has been temporarily locked");

          }
        }
      }

      return "Signed in";
    } on FirebaseException catch (e) {
      showAlertDialog(ctx!, "Incorrect email or password. Please try again");
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

      DBRef.doc(FirebaseAuth.instance.currentUser!.uid).set({
        'email': email,
        'name': name,
        'password': password,
        'phone': phone,
        'allow': allow
      });
      //create the user in the database
      saveData(email: email, password: password);

      Navigator.pushReplacement(
        ctx!,
        MaterialPageRoute(builder: (context) => Home_screen()),
      );

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
    Widget okButton = TextButton(
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

  updateuser(String name, String Phone) {
    DBRef.doc(FirebaseAuth.instance.currentUser!.uid).update({
      'name': name,
      'phone': Phone,
    });
  }

  sendMailVerification(FirebaseAuth currentAuth, BuildContext? ctx) {
    try {
      currentAuth.currentUser!.sendEmailVerification();
      showAlertDialog(ctx!, "Please check your Email");
    } catch (e) {
      print("An error occurred while trying to send email verification");
      // print(e.message);
    }
  }

  // Check Internet Connection
  Future<bool> isInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network, make sure there is actually a net connection.
      if (await DataConnectionChecker().hasConnection) {
        // Mobile data detected & internet connection confirmed.
        return true;
      } else {
        // Mobile data detected but no internet connection found.
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a WIFI network, make sure there is actually a net connection.
      if (await DataConnectionChecker().hasConnection) {
        // Wifi detected & internet connection confirmed.
        return true;
      } else {
        // Wifi detected but no internet connection found.
        return false;
      }
    } else {
      // Neither mobile data or WIFI detected, not internet connection found.
      return false;
    }
  }

  // End Internet

  Updatedloaction(String id, String Location, String Image, double latitude,
      double longitude) async {
    var result = await DBRe.add({
      'id': id,
      'location': Location,
      "latitude": latitude,
      "longitude": longitude,
      'image': Image,
    });
    return result.id;
  }
}
