// ************** imports ****************
import 'dart:ui';
import 'home/profile.dart';
import 'home/messenger.dart';
import 'home/gyms.dart';
import 'home/calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


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
  String gyms;


  @override
  void initState() {
    getCurrentUser();
  }

  void gymStream() async {
    await for(var snapshot in _firestore.collection("Gyms").snapshots()) {
      for(var info in snapshot.docs) {
        print(info.data());
      }
    }
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
  // 1 profile, 2 messages, 3 gyms, 4 calendar.
  int _currentIndex = 0;
  // list of sections
  final List<Widget> tabs = [
    /*Center(
      child: Text('Profile'),
    ),
    Center(
      child: Text('Messages'),
    ),
    Column(
        children: <Widget>[ Text("Gyms"),
        ]),
    Center(
      child: Text('Calendar'),
    ),*/
    Profile(),
    Messenger(),
    Gyms(),
    Calendar(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            //print("Hello");
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
            icon: Icon(Icons.logout),
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),//***********************************************************
      body: /*Column(
        children: <Widget>[
          Container(
              child: Text(
                  "Welcome " + loggedInUser.email
              )
          ),
          Container(
            child: InkWell(
                child: Text("It's time to be someone at the Gym!",
                    style: kLoginTextStyle,
                ),
                onTap: () => launch('https://nullpointerexception.greenriverdev.com/Spotlight/index.php')
            ),
          ),
          Image(
            image: AssetImage('assets/images/gym5.jpg'),
          ),
          tabs[_currentIndex]
        ],
      ),*/
      tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30.0,
        unselectedFontSize: 14.0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.contacts_rounded),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: 'Education',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Gyms',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded),
            label: 'Calendar',
          ),
        ],
        onTap: (index){
          setState(() {
            _currentIndex = index;

            }
          );
        },
      ),
    );
  }
}

