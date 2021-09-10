import 'package:carousel_slider/carousel_slider.dart';
import 'package:findus/Model/Model.dart';
import 'package:findus/Screen/MapView.dart';
import 'package:flutter/material.dart';

import '../Theme.dart';

class viewItem extends StatefulWidget {
  final Item item1;
  final bool view;
  final String id;
  viewItem(this.item1, this.view, this.id, {Key? key}) : super(key: key);

  @override
  _viewItemState createState() => _viewItemState();
}

class _viewItemState extends State<viewItem> {
  int _currentIndex = 0;
  late String codeDialog;
  late String valueText;
  TextEditingController _textFieldController = TextEditingController();

 
  
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
                                // longitude: 20.00,
                                // latitude: 34.44,
                                id: widget.id,
                              )),
                    );
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
                              text: " Gender : ",
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
                    ? 
                    Container()
                    
                //     Container(
                //  child: Align(
                //   alignment: Alignment.bottomCenter,
                //   child: ButtonBar(
                //     alignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       OutlinedButton(
                //           style: OutlinedButton.styleFrom(
                //             primary: Colors.white,
                //             // backgroundColor: Colors.teal,
                //             side: BorderSide(
                //                 color: MyColors.primaryColor, width: 1),
                //           ),
                //           onPressed: () {
                //             // _displayTextInputDialog(context);
                //             // Navigator.of(context).push(MaterialPageRoute(
                //             //     builder: (_) => Clim_Screen(
                //             //       id: widget.id,
                //             //     )));
                //               Navigator.of(context).push(MaterialPageRoute(
                //                       builder: (_) => MapView(
                //                             latitude: widget.item1.latitude!,
                //                             longitude:  widget.item1.longitude!,
                //                             id: widget.id,
                //                             check: false,
                //                           )));
                //           },
                //           child: Text(
                //             'Sighted Location',
                //             style: TextStyle(
                //                 color: MyColors.primaryColor,
                //                 fontSize: 17),
                //           )),
                //     ],
                //   ),
                // ),)
                   
                   
                   
                    :
                    
                     Align(
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
                                  // print(location!.latitude);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => MapView(
                                            // latitude: widget.item1.latitude!,
                                            // longitude:  widget.item1.longitude!,
                                            check: true,
                                            id: widget.id,
                                          )));
                                  // if (latitude != 0.0) {
                                  // } else {
                                  //   print("Null");
                                  // }
                                },
                                child: Text(
                                  'Have Seen This Child',
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
