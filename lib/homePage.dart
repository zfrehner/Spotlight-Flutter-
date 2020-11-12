// ************** imports ****************
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
//****************************************

class LandPage extends StatefulWidget {

  static const String id = 'home_screen';

  @override
  _LandPageState createState() => _LandPageState();

}
class _LandPageState extends State<LandPage> {
  // current index variable; value changes based on icon selected: 0 Profile,
  // 1 Messages, 2 Location, 3 Workout.
  int _currentIndex = 0;
  // list of sections
  dynamic tabs = [
    Center(
      child: Text('Profile'),
    ),
    Center(
      child: Text('Messages'),
    ),
    Center(
      child: Text('Location'),
    ),
    Center(
      child: Text('Workout'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Hero(
            tag: 'logo',
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/LOGO 4.jpg'),
            ),
          ),
        ),
        centerTitle: true,
        title: Center(
          child: Text(
              'SPOTLIGHT',
              style: TextStyle(fontSize: 30.0,)
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings,),
            onPressed: null,
          ),
        ],
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: <Widget>[
          Container(
          child: InkWell(
          child: Text("See Who's at the Gym!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16
          )),
          onTap: () => launch('https://nullpointerexception.greenriverdev.com/Spotlight/index.php')
    ),
    ),
          Image(
            image: AssetImage('assets/images/gym5.jpg'),
          ),
          tabs[_currentIndex],
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30.0,
        unselectedFontSize: 14.0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        backgroundColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.contacts_rounded),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.markunread),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place),
            label: 'Location',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.scatter_plot),
            label: 'Workout',
          ),
        ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}