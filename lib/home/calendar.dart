import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import '../workout_classes/workout.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';
import '../workout_classes/workout_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

/// Additional code can be found in workout_widgets.dart

final _auth = FirebaseAuth.instance;  // Firebase Authentication Instance
var firebaseUser = FirebaseAuth.instance.currentUser; // The current App User
FirebaseFirestore _firestore = FirebaseFirestore.instance;  // Firebase Firestore Instance

User loggedInUser;  // User variable
var uid;  // User ID variable

// Initializes State of the page
void initState() {
  getCurrentUser();
}

// Initializes User and uid variables
void getCurrentUser() async {
  try { // Gets the user and user ID from the database
    final user = _auth.currentUser;
    final fireUser = FirebaseAuth.instance.currentUser.uid;

    if (user != null) { // If the user has been found, sets the loggedInUser and uid variables
                        // with what's on the database
      loggedInUser = user;
      uid = fireUser;
      //print(loggedInUser.email);
    }
  } catch (e) { // If the user doesn't exist, an error is thrown
    print(e);
  }
}

// Gets the current user UID
Future<String> getCurrentUID() async {
  return firebaseUser.uid;
}

// Gets the current user info
Future getAuthUserInfo() async {
  return firebaseUser;
}

// Gets the current user's document
Future getFirestoreUser() async {
  return _firestore.collection("SpotlightUsers").doc(firebaseUser.uid).get();
}

// Sets the state of the App to the Calendar Page
class _CalendarState extends State<Calendar> {

  DateTime _currentDate = DateTime.now(); // Gets the current date
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");  // Formats date by: Year/Month/Day Hour:Minutes:Seconds
  String monthYear = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());  // Formats Current date to the date format above
  String workoutDate = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());  // Formats Current date to the date format above

  /* Indicator Code (Went Unfinished) */

  // What days have a valid workout plan (Part of the unfinished Indicator)
  Map<String, bool> daysWorkedOut = {

  };

  // Sets 31 days to false for the daysWorkedOut map (Part of the unfinished Indicator)
  void buildMap() {
    for (var i = 0; i < 32; i++) {
      String temp = i.toString();
      daysWorkedOut[temp] = false;
    }
  }

  // Gets Workout Scheduler for a given date from the database
  Future getWorkoutScheduler(date) async {
    // Get document from database
    var doc = await _firestore
        .collection("SpotlightUsers")
        .doc(firebaseUser.uid)
        .collection("WorkoutScheduler").doc("workout"+date).get();

    // If the document exists, return what was set for that date
    if(doc.exists){
      return _firestore
          .collection("SpotlightUsers")
          .doc(firebaseUser.uid)
          .collection("WorkoutScheduler")
          .doc("workout"+date)
          .get();
    }
  }

  // Sets all the bool variables of the daysWorkedOut Map depending on
  // if the user has worked out on the given day
  Future<dynamic> assignDaysWorkedOut(context, snapshot, date) async{
    for (String day in daysWorkedOut.keys) {
      daysWorkedOut[day] = getBoxes(context, snapshot, date);
    }
  }

  // Returns true if the user has worked out that day, false otherwise
  bool getBoxes(BuildContext context, snapshot, String date) {
    try {
      return snapshot.data["workedOut"];
    } catch(e) {
      return false;
    }
  }

  // Tries to set the daysWorkedOut map while returning an empty text Widget
  // Does not seem to work in practice
  Widget temp(context, snapshot, date) {
    assignDaysWorkedOut(context, snapshot, date);

    return Text('');
  }

  /* Indicator Code End */

  // Build Method
  @override
  Widget build(BuildContext context) {
    buildMap();
    workoutDate = DateFormat("yyyy-MM-dd").format(_currentDate);
    FutureBuilder(  // Tries to set the daysWorkedOut map via the temp method
        future: getWorkoutScheduler(workoutDate),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return temp(context, snapshot, workoutDate.substring(8,10));
          }
          else {
            return CircularProgressIndicator(backgroundColor: Colors.red,);
          }
        }
    );
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        child: CalendarCarousel(  // Creates the calendar
        onDayPressed: (DateTime date, List events) {  // Moves to Workout Page for selected date
        this.setState(() => _currentDate = date);
        // Navigator.pushNamed(context, '/workout',
        //     arguments: 7);
        Navigator.pushNamed(context, Workout.id,arguments: _currentDate);

        },
        //this is what set the headerText down below when you click the left
        //and right arrows on the calendar. Ex. September - 2021, December - 2021
          onCalendarChanged: (DateTime date){
            this.setState(() {
              monthYear = dateFormat.format(date);
            });
          },

          // Calendar text styles
        weekendTextStyle: TextStyle(
        color: Colors.red,
            fontWeight: FontWeight.bold,
        ),
        thisMonthDayBorderColor: Colors.white,
        daysTextStyle: TextStyle(

        color: Colors.white,
            fontWeight: FontWeight.bold,
        ),
        headerTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        ),
          headerText: '${formatDate(
              DateTime.parse(monthYear), [MM, ' ', yyyy])}',
        iconColor: Colors.white,
    //      weekDays: null, /// for pass null when you do not want to render weekDays
    //      headerText: Container( /// Example for rendering custom header
    //        child: Text('Custom Header'),
    //      ),
        customDayBuilder: (   /// you can provide your own build function to make custom day containers
        bool isSelectable,
        int index,
        bool isSelectedDay,
        bool isToday,
        bool isPrevMonthDay,
        TextStyle textStyle,
        bool isNextMonthDay,
        bool isThisMonthDay,
        DateTime day,
        ) {
          String dayString = day.toString().substring(8,10);
        /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
        /// This way you can build custom containers for specific days only, leaving rest as default.
        // Example: every 15th of month, we have a flight, we can place an icon in the container like that:

          /// Note: Our client really wants this calendar to have an indicator for if a user has worked out that day
          /// and the last group to work on this project couldn't quite get it to work, so it's recommended
          /// that future groups work on this part as soon as they can.
          ///
          /// A possible solution is to return this entire CalendarCarousel widget as a FutureBuilder Widget

        // turns calendar date green if its index on the daysWorkedOut Map is set to true
        if (daysWorkedOut[day.day.toString()] == true ) {
        return Center(
        child: Text(
            dayString,
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            )
        ),
        );
        } else {
        return null;
        }

        },
        weekFormat: false,
        //markedDatesMap: _markedDateMap,
        height: 420.0,
        selectedDateTime: _currentDate,
        selectedDayBorderColor: Colors.white,
        selectedDayButtonColor: Colors.white24,
        daysHaveCircularBorder: null, /// null for not rendering any border, true for circular border, false for rectangular border
        ),
        ),
        Container(  // Displays user's workout notes for the selected day
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: FutureBuilder(
                    future: getWorkoutScheduler(workoutDate),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return displayWorkoutNotes(context, snapshot,_currentDate);
                      }
                      else {
                        return CircularProgressIndicator(backgroundColor: Colors.red,);
                      }
                    }
                ),
              ),
            )
        )
      ],
    );

  }
}