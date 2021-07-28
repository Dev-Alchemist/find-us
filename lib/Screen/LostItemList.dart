import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findus/Model/Model.dart';
import 'package:findus/Theme.dart';
import 'package:flutter/material.dart';

import 'ViewItem.dart';
class Lostitem extends StatefulWidget {
  const Lostitem({Key? key}) : super(key: key);

  @override
  _LostitemState createState() => _LostitemState();
}

class _LostitemState extends State<Lostitem> {
  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Items').where(
          "find", isEqualTo: false).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Container(child: Center(child: Text("Loading...")));
        }
        int length = snapshot.data!.docs.length;

        return length > 0 ? ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: length,
          padding: const EdgeInsets.all(2.0),
          itemBuilder: (_, index) {
            var item = snapshot.data!.docs[index];
            var item1= Item.fromJson(snapshot.data!.docs[index].data() as Map<String,dynamic>);
            String Id = snapshot.data!.docs[index].id;
            return InkWell(

              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: MyColors.primaryColor)),
                  elevation: 10.0,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),

                            child: Image.network(
                              (item.get('image') as List<dynamic>).first
                                  .toString(), height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.1,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.2,),

                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 2.5,
                            child: Text(
                              item.get('name').toString(),
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                          ),
                        ],
                      ),
                      Row(

                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          " Location:  ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          item.get('location').toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "   Age:  ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          item.get('age').toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                ElevatedButton(onPressed: (){

                                  Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => viewItem(item1,false,Id)),);
                                }, child: Text("View Child",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            );
          },
        ) :
        Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Thank you for using our service. No new reported incidents of missing items currently, we will update here in case of reported cases otherwise check next screen and help others who have lost",
              style: TextStyle(color: MyColors.primaryColor,fontSize: 25),),
            ),
          ),
        );
      },
    );
  }
}