import 'dart:async';

import 'package:findus/Screen/Desktop.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getUser();
  }
  getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = pref.getString("email");
    if (data != null) {
      return true;
    } else {
      return false;
    }
  }
  getUser() async {
    // String a = await checkUser();
    bool check = await getData();
    if (check != null) {
      check = check;
    } else {
      check = false;
    }

    Timer(
        Duration(seconds: 6),
        check
            ? () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => Home_screen()))
            : () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => Login_scrren())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     fit: BoxFit.contain,
        //     image: AssetImage('assets/images/findusicon.png'),
        //   ),
        // ),
         child : Image.asset('assets/images/findusicon.png'),
        // )
      ),
    );
  }
}
