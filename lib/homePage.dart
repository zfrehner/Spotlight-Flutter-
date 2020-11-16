// ************** imports ****************
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
//****************************************

class LandPage extends StatefulWidget {

  static const String id = 'home_screen';

  @override
  _LandPageState createState() => _LandPageState();

}

class _LandPageState extends State<LandPage> {
  final _auth = FirebaseAuth.instance;
  var firebaseUser =  FirebaseAuth.instance.currentUser;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User loggedInUser;

  @override
  void initState() {
    getCurrentUser();
  }

   getUserInfo() async{
    return await _firestore.collection('SpotlightUsers').doc(firebaseUser.uid).get();
      //print(userInfo);

    //for(var info in userInfo.docs) {
    //  print(info.data());
    //}

  }

  void getCurrentUser() async {
    try{
      final user = _auth.currentUser;

      if(user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      } }
    catch(e) {
      print(e);
    }
  }
  // current index variable; value changes based on icon selected: 0 Profile,
  // 1 Messages, 2 Location, 3 Workout.
  int _currentIndex = 1;
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
      child: Text('Calendar'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            //does nothing for now
          },
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
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: <Widget>[
          Container(
          child: InkWell(
          child: Text("It's time to be someone at the Gym!",
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
            icon: Icon(Icons.calendar_today_rounded ),
            label: 'Calendar',
          ),
        ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
            if(_currentIndex == 0) {
              getUserInfo();
            }

          });
        },
      ),
    );
  }
}