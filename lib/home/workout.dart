
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'workouts.dart';
import 'package:intl/intl.dart';



class Workout extends StatefulWidget {
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

    Workouts()
  ];

  int _currentIndex = 0;
  var today = new DateTime.now();

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
               DateFormat("MMMMd").format(today)+' workout',
              style: TextStyle(fontSize: 30.0,)
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
        iconSize: 30.0,
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