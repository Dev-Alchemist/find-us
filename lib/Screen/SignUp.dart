import 'package:findus/Model/authentication_service.dart';
import 'package:findus/Screen/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Theme.dart';

class Singup_screen extends StatefulWidget {
  const Singup_screen({Key? key}) : super(key: key);

  @override
  _Singup_screenState createState() => _Singup_screenState();
}

class _Singup_screenState extends State<Singup_screen> {

  final TextEditingController nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @required TextEditingController phoneController = TextEditingController();
  TextEditingController emialController = TextEditingController();


  String? validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    }
    else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }




  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

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
                      'Sign Up',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (val) => val!.isEmpty && val.length <2 ? 'Ensure username is more than 2 letters' : null,
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      prefixIcon: Icon(
                        Icons.person,
                        size: 30.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: emialController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      prefixIcon: Icon(
                        Icons.email_outlined
                      ),

                    ),
                    keyboardType:TextInputType.emailAddress,
                  ),
                ),
                 Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                      controller: _passwordController,
                        validator: (val) => val!.length < 6 ? 'Enter a password 6+ long' : null,
                        onSaved: (val) => _passwordController = val as TextEditingController,
                        obscureText: _obscureText,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        suffix: InkWell(
                          onTap: _toggle,
                          child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                        )
                      ),
                    ),


                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    validator: (val) {
                      return val!.length < 9 ? 'Phone number input is not correct' : null;
                      },
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                      prefixIcon: Icon(
                        Icons.phone_iphone,
                        size: 30.0,
                      ),

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
                          AuthenticationService(FirebaseAuth.instance).showAlertDialog(context,"Please enter a valid email address");
                        }else if (_passwordController.text.isEmpty){
                          AuthenticationService(FirebaseAuth.instance).showAlertDialog(context,"Please enter a valid password");
                        }else if (phoneController.text.isEmpty){
                          AuthenticationService(FirebaseAuth.instance).showAlertDialog(context,"Please enter valid phone number");
                        }else  {
                          AuthenticationService(FirebaseAuth.instance).signUp(
                            ctx: context,
                              allow: true,
                              email: emialController.text,
                              password: _passwordController.text,
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
