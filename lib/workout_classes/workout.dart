
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'workouts.dart';
import 'package:intl/intl.dart';
import 'package:spotlight_login/home/calendar.dart';
import 'package:spotlight_login/home/gyms.dart';
import 'package:spotlight_login/home/messenger.dart';
import 'package:spotlight_login/home/profile.dart';



class Workout extends StatefulWidget {
  static const String route = '/workout';
  static const String id = "workout";
  @override
  _WorkoutState createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  @override

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
    Calendar(),
    Gyms(),
    Messenger(),
    Workouts()
  ];

  int _currentIndex = 4;
  
  

  Widget build(BuildContext context) {
    // var today = _currentDate;
    var args = ModalRoute.of(context).settings.arguments;
    var today = args.toString();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Center(
          child: Text(
               args.toString().substring(0,10)+' workout',
              style: TextStyle(fontSize: 25.0,)
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              //_auth.signOut();
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
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 0.0,
        unselectedFontSize: 14.0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        //currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.contacts_rounded),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Gyms',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: 'Education',
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