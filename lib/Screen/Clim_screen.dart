import 'dart:io';

import 'package:findus/Model/authentication_service.dart';
import 'package:findus/Screen/Desktop.dart';
// import 'package:findus/Screen/FindItemList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

class Clim_Screen extends StatefulWidget {
  double longitude = 0.0, latitude = 0.0;
  String id;
  Clim_Screen(
      {required this.id, required this.latitude, required this.longitude});

  @override
  _Clim_ScreenState createState() => _Clim_ScreenState();
}

class _Clim_ScreenState extends State<Clim_Screen> {
  File? _image;
  FirebaseStorage _storage = FirebaseStorage.instance;

  TextEditingController locationController = TextEditingController();

//  Location _locationService = Location();
//   bool _permission = false;
//   @override
//   void initState() {
//     super.initState();
//     initLocationService();
//   }
//   LocationData? locationData;

//   double longitude = 0.0, latitude = 0.0;

//   void initLocationService() async {
//     await _locationService.changeSettings(
//       accuracy: LocationAccuracy.high,
//       interval: 1000,
//     );

//     LocationData location;
//     bool serviceEnabled;
//     bool serviceRequestResult;

//     try {
//       print("Here");
//       serviceEnabled = await _locationService.serviceEnabled();

//       if (serviceEnabled) {
//         var permission = await _locationService.requestPermission();
//         _permission = permission == PermissionStatus.granted;

//         if (_permission) {
//           location = await _locationService.getLocation();
//           print(latitude);
//           locationData= location;

//           latitude = location.latitude!;
//           longitude = location.longitude!;
//           print(latitude);
//           setState(() {});
//         }
//       } else {
//         serviceRequestResult = await _locationService.requestService();
//         if (serviceRequestResult) {
//           initLocationService();
//           return;
//         }
//       }
//     } on PlatformException catch (e) {
//       print(e.message);
//       if (e.code == 'PERMISSION_DENIED') {
//         // _serviceError = e.message!;
//         print(e.message);
//       } else if (e.code == 'SERVICE_STATUS_ERROR') {
//         // _serviceError = e.message!;
//         print(e.message);
//       } //location =un
//     }
//   }

  _imgFromCamera() async {
    File image;
    var abc = await ImagePicker.platform
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    image = File(abc!.path);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image;
    var abc = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    image = File(abc!.path);

    setState(() {
      _image = image;
    });
  }

  Future<String> uploadFile() async {
    try {
      DateTime date = DateTime.now();
      Reference storageReference =
          FirebaseStorage.instance.ref().child('client/${date.toString()}.jpg');
      // String returnURL = "error";
      print("Here");
      UploadTask uploadTask = storageReference.putFile(_image!);
      print("Here1");

      await uploadTask.whenComplete(() {});
      print("Here2");

      return await storageReference.getDownloadURL();
    } catch (error) {
      return "error";
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Describe Sighting'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 32,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: CircleAvatar(
                radius: 55,
                child: _image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.file(
                          _image!,
                          width: 200,
                          height: 200,
                          fit: BoxFit.fitHeight,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(50)),
                        width: 100,
                        height: 100,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: locationController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Please Provide More Details',
              ),
            ),
          ),
          Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: Text('Upload Sighted Location'),
                onPressed: () async {
                  showAler(context);

                  if (locationController.text.isEmpty) {
                    AuthenticationService(FirebaseAuth.instance)
                        .showAlertDialog(
                            context, "Please Enter Sighted Location");
                  } else {
                    String image_url = await uploadFile();
                    if (image_url == "error") {
                      Navigator.pop(context);
                    } else {
                      
                      String re =
                          await AuthenticationService(FirebaseAuth.instance)
                              .Updatedloaction(
                                  widget.id,
                                  locationController.text,
                                  image_url,
                                  widget.latitude,
                                  widget.longitude);
                      print(re);
                      Navigator.pop(context);
                      showAlertDialog(context, "Data Upload Successful ");
                    }
                  }
                },
              )),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context, String mess) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => Home_screen()),
        // );
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

  showAler(BuildContext context) {
    // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
        title: Text("Please Wait"),
        content: Container(
          child: Center(
              child: CircularProgressIndicator(
            strokeWidth: 2,
          )),
          width: 100,
          height: 100,
        ));

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
