import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:findus/Screen/LostItemList.dart';
import 'package:findus/Theme.dart';
import 'package:flutter/material.dart';

import 'FindItemList.dart';
import 'ProfileScreen.dart';
import 'Report.dart';
class Home_screen extends StatefulWidget {
  const Home_screen({Key? key}) : super(key: key);

  @override
  _Home_screenState createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  int _currentIndex = 0;
  final pageList = [Lostitem(),FinditemList(),Profile_screen()];

  @override
  Widget build(BuildContext context) {
      return  Scaffold(
      appBar:AppBar(
      title: Center(child: Text('Missing Child',style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),)),
    ),
      body:  pageList[_currentIndex],
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() => _currentIndex = index),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Recent'),
            activeColor: MyColors.primaryColor,
            textAlign: TextAlign.center,
          ),
          // BottomNavyBarItem(
          //    icon: Icon(Icons.report),
          //   title: Text('Report'),
          //   activeColor:  MyColors.primaryColor,
          //   textAlign: TextAlign.center,
          // ),
          BottomNavyBarItem(
            icon: Icon(Icons.find_in_page),
            title: Text(
              'Cases',
            ),
            activeColor: MyColors.primaryColor,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(

            icon: Icon(Icons.person),
            title: Text('Profile'),
            activeColor: MyColors.primaryColor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
