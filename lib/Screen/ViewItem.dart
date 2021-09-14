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
        )
        ),
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
                                        fit: BoxFit.fitHeight)
                                ),
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

          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Row(
              children: <Widget>[
                Text("\u{1F466}Name :",style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),),
                SizedBox(width: 5,),
                Text(widget.item1.name!,style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                ),)

              ],
            ),
          ),
          SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Row(
              children: <Widget>[
                Text("\u{1F46A} Gender :",style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),),
                SizedBox(width: 5,),

                Text(widget.item1.gender!,style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                ),)

              ],
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Row(
              children: <Widget>[
                Text("\u{1F4C5} Age :",style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                ),
                ),
                SizedBox(width: 5,),

                Text(widget.item1.age!,style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                ),
                )

              ],
            ),
          ),

          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Row(
              children: <Widget>[
                Text("\u{1F4CD}Last Seen Location :",style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),),
                SizedBox(width: 5,),

                Text(widget.item1.location!,
                  softWrap: true,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                ),
                )

              ],
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
              child: Row(
                children: <Widget>[
                  Text("\u{1F4D6}More Details:",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                  ),),
                  SizedBox(width: 5,),
                  Flexible(
                    child: Text(widget.item1.description!,
                          softWrap: true,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                        ),),
                  ),
                ],
              ),
          ),
          SizedBox(height: 20,),

                widget.view
                    ?
                    Container() : Align(
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => MapView(
                                            // latitude: widget.item1.latitude!,
                                            // longitude:  widget.item1.longitude!,
                                            check: true,
                                            id: widget.id,
                                          )
                                  )
                                  );
                                },
                                child: Text(
                                  'Have Seen This Child',
                                  style: TextStyle(
                                      color: MyColors.primaryColor,
                                      fontSize: 17),
                                )
                            ),
                          ],
                        ),
                      ),

        ],
      ),
    );
  }
}
