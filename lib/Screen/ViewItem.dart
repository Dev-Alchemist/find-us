import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findus/Model/Model.dart';
import 'package:findus/Screen/MapView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';

import '../Theme.dart';
import 'Clim_screen.dart';

class viewItem extends StatefulWidget {
  Item item1;
  bool view;
  String id;
  viewItem(this.item1, this.view, this.id, {Key? key}) : super(key: key);

  @override
  _viewItemState createState() => _viewItemState();
}

class _viewItemState extends State<viewItem> {
  int _currentIndex = 0;
  late String codeDialog;
  late String valueText;
  TextEditingController _textFieldController = TextEditingController();

  Location _locationService = Location();
  bool _permission = false;
  @override
  void initState() {
    super.initState();
    initLocationService();
    // getLoC();
  }

  double longitude = 0.0, latitude = 0.0;

  void initLocationService() async {
    await _locationService.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 1000,
    );

    LocationData location;
    bool serviceEnabled;
    bool serviceRequestResult;

    try {
      print("Here");
      serviceEnabled = await _locationService.serviceEnabled();

      if (serviceEnabled) {
        var permission = await _locationService.requestPermission();
        _permission = permission == PermissionStatus.granted;

        if (_permission) {
          location = await _locationService.getLocation();
          print(latitude);

          latitude = location.latitude!;
          longitude = location.longitude!;
          print(latitude);
          setState(() {});
        }
      } else {
        serviceRequestResult = await _locationService.requestService();
        if (serviceRequestResult) {
          initLocationService();
          return;
        }
      }
    } on PlatformException catch (e) {
      print(e.message);
      if (e.code == 'PERMISSION_DENIED') {
        // _serviceError = e.message!;
        print(e.message);
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        // _serviceError = e.message!;
        print(e.message);
      } //location =un
    }
  }

  // getLoC() {
  //   getLocation().then((value) {
  //     if (value == null) {
  //       getLoC();
  //     } else {
  //       latitude = value.latitude;
  //       longitude = value.longitude;
  //       print(latitude);
  //       print(longitude);

  //       // setState(() {});
  //     }
  //   });
  // }

  // Future<Position> getLocation() async {
  //   try {
  //     LocationPermission permission;
  //     permission = await Geolocator.checkPermission();

  //     if (permission == LocationPermission.denied) {
  //       permission = await Geolocator.requestPermission();

  //       if (permission == LocationPermission.denied) {
  //         return null;
  //       }
  //     } else {
  //       Position position = await GeolocatorPlatform.instance
  //           .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //       return position;
  //     }
  //   } catch (ex) {
  //     return null;
  //   }
  // }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Find Child Location'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(
                  hintText: "Please Enter Sighted Child Location "),
            ),
            actions: <Widget>[
              FlatButton(
                color: MyColors.primaryColor,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    //  codeDialog = valueText;

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MapView(
                                longitude: 20.00,
                                latitude: 34.44,
                                id: widget.id,
                              )),
                    );

                    // Map<String, dynamic> data = {
                    //   "find": true,
                    //   "finditemlocation" : valueText
                    // };
                    // FirebaseFirestore.instance
                    //     .collection("Items")
                    //     .doc(widget.id)
                    //     .update(data).then((value) {
                    //       Navigator.pop(context);
                    // })
                    //     .catchError((onError) {});
                    // Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Missing Child',
          style: TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
        )),
      ),
      body: Column(
        children: [
          Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 4 / 4,

                  autoPlay: true,
                  // enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(
                      () {
                        _currentIndex = index;
                      },
                    );
                  },
                ),
                items: widget.item1.image!
                    .map(
                      (path) => Card(
                        elevation: 6.0,
                        shadowColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(path.toString()),
                                        fit: BoxFit.fitHeight)),
                              ),
                              // Center(
                              //   child: TextButton(
                              //       onPressed: () {
                              //         // showImageDialoge(context,
                              //         // path.toString());
                              //       },
                              //       child: Text(
                              //         "View",
                              //         style: TextStyle(
                              //           fontSize: 24.0,
                              //           fontWeight: FontWeight.bold,
                              //           backgroundColor: Colors.black45,
                              //           color: Colors.white,
                              //         ),
                              //       )),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.item1.image!.map((e) {
                  int index = widget.item1.image!.indexOf(e);
                  return Container(
                    width: 10.0,
                    height: 10.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? Color.fromRGBO(0, 0, 0, 0.8)
                          : Color.fromRGBO(0, 0, 0, 0.3),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
          Expanded(
            child: Stack(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Card(
                    color: MyColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            widget.item1.name!,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                              text: "Gender : ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              children: [
                                TextSpan(
                                    text: widget.item1.gender!,
                                    style: TextStyle(
                                        color: Colors.black,
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 14))
                              ]),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon:
                                Icon(Icons.location_pin, color: Colors.white)),
                        Text(widget.item1.location!,
                            style: TextStyle(
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                                fontSize: 14)),
                      ],
                    ),
                  ),
                ),
                // widget.view
                //     ? Container()
                //     : Padding(
                //         padding: const EdgeInsets.only(top: 60, bottom: 40),
                //         child: Material(
                //           child: Column(
                //             children: [
                //               Padding(
                //                 padding: const EdgeInsets.symmetric(
                //                     horizontal: 10, vertical: 5),
                //                 child: Text(
                //                   "Item Find Location",
                //                   style: TextStyle(
                //                       color: MyColors.primaryColor,
                //                       fontWeight: FontWeight.bold,
                //                       fontSize: 18),
                //                 ),
                //               ),
                //               Expanded(
                //                   child: SingleChildScrollView(
                //                 child: Container(
                //                   margin: const EdgeInsets.all(15.0),
                //                   padding: const EdgeInsets.all(3.0),
                //                   decoration: BoxDecoration(
                //                       border: Border.all(
                //                           color: MyColors.primaryColor)),
                //                   child: Text(
                //                     widget.item1.finditemlocation!,
                //                     textAlign: TextAlign.justify,
                //                     style: TextStyle(fontSize: 15),
                //                   ),
                //                 ),
                //               ))
                //             ],
                //           ),
                //         ),
                //       ),

                Padding(
                  padding: const EdgeInsets.only(top: 60, bottom: 40),
                  child: Material(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Text(
                            "Description ",
                            style: TextStyle(
                                color: MyColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                          child: Container(
                            margin: const EdgeInsets.all(15.0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: MyColors.primaryColor)),
                            child: Text(
                              widget.item1.description!,
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
                widget.view
                    ? Container(
                 child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            primary: Colors.white,
                            // backgroundColor: Colors.teal,
                            side: BorderSide(
                                color: MyColors.primaryColor, width: 1),
                          ),
                          onPressed: () {
                            // _displayTextInputDialog(context);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => clim_screen(
                                  id: widget.id,
                                )));

                          },
                          child: Text(
                            'Sighted Location',
                            style: TextStyle(
                                color: MyColors.primaryColor,
                                fontSize: 17),
                          )),
                    ],
                  ),
                ),)
                    : Align(
                        alignment: Alignment.bottomCenter,
                        child: ButtonBar(
                          alignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  primary: Colors.white,
                                  // backgroundColor: Colors.teal,
                                  side: BorderSide(
                                      color: MyColors.primaryColor, width: 1),
                                ),
                                onPressed: () {
                                  // _displayTextInputDialog(context);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => MapView(
                                            latitude: latitude,
                                            longitude: longitude,
                                            id: widget.id,
                                          )));
                                  if (latitude != 0.0) {
                                  } else {
                                    print("Nullllllll");
                                  }
                                },
                                child: Text(
                                  'View Map',
                                  style: TextStyle(
                                      color: MyColors.primaryColor,
                                      fontSize: 17),
                                )),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
