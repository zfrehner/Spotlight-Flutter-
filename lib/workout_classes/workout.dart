import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';

class Workout extends StatefulWidget {
  static const String route = '/workout';
  static const String id = "workout";

  @override
  _WorkoutState createState() => _WorkoutState();
}

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
  try {
    final user = _auth.currentUser;
    final fireUser = FirebaseAuth.instance.currentUser.uid;

    if (user != null) {
      loggedInUser = user;
      uid = fireUser;
      //print(loggedInUser.email);
    }
  } catch (e) {
    print(e);
  }
}

// Get the current user UID (Unused)
Future<String> getCurrentUID() async {
  return firebaseUser.uid;
}

// Get the current user info (Unused)
Future getAuthUserInfo() async {
  return firebaseUser;
}

// Gets user document from Firestore based on user UID (Unused)
Future getFirestoreUser() async {
  return _firestore.collection("SpotlightUsers").doc(firebaseUser.uid).get();
}

// Grabs Workout Scheduler (by date) if it exists
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

// Sets the state of the App to the Workout Page
class _WorkoutState extends State<Workout> {
  @override
  final _auth = FirebaseAuth.instance;  // Firebase Authentication Instance
  var firebaseUser = FirebaseAuth.instance.currentUser; // The current App User (Unused in _WorkoutState)
  FirebaseFirestore _firestore = FirebaseFirestore.instance;  // Firebase Firestore Instance

  User loggedInUser;  // User variable (Unused in _WorkoutState)
  var uid;  // User ID variable (Unused in _WorkoutState)

  /* Workout Checkboxes */

  // Workouts group 1
  Map<String, bool> workouts = {
    'Biceps': false,
    'Triceps': false,
    'Chest': false,
    'Shoulders': false,
    'Back': false,
    'Legs': false,
  };

  // Workouts group 2
  Map<String, bool> workoutsTwo = {
    'Circuits': false,
    'Run': false,
    'Ropes': false,
    'Swim': false,
    'Sports': false,
    'Placeholder': false,
  };

  // Sets the two sets of workout boxes with what's on the database
  Future<dynamic> assignWorkoutBool(context, snapshot, date) async{
    for (String workoutName in workouts.keys) { // workout list 1
      workouts[workoutName] = getBoxes(context, snapshot, date, workoutName);
    }
    for (String workoutName in workoutsTwo.keys) {  // workout list 2
      workoutsTwo[workoutName] = getBoxes(context, snapshot, date, workoutName);
    }
  }

  // Gets whether or not the box for the given day has been set to true/false,
  // creates the field in the document if it hasn't
  bool getBoxes(BuildContext context, snapshot, String date, String workout) {
    try {
      return snapshot.data[workout];
    } catch(e) {
      createBoxesDoc(date, workout);
      return false;
    }
  }

  // Sets a workout field of given name and date,
  // If the field doesn't exist in the document, it is created
  void createBoxesDoc(date, workout) async {
    await _firestore
        .collection("SpotlightUsers")
        .doc(_auth.currentUser.uid)
        .collection("WorkoutScheduler")
        .doc("workout"+date)
        .set({workout: false}, SetOptions(merge: true));
  }

  // Creates Workout Checkbox Widgets for a given group of workouts (1 - 2)
  Widget getWorkouts(BuildContext context, snapshot, String fullDate, group) {
    // get and assign bool to workouts group 1
    assignWorkoutBool(context, snapshot, fullDate);
    Map<String, bool> temp; // Stores Workout name and what its checkbox is set to
    if(group == 1) {
      temp = workouts;  // Sets temp with what's in workouts group 1
    } else if(group == 2) {
      temp = workoutsTwo; // Sets temp with what's in workouts group 2
    }

    // Returns a vertical list of checkboxes for the given workout group
    return ListView(
      children: temp.keys.map((String key) {
        return new CheckboxListTile(
          checkColor: Colors.white,
          activeColor: Colors.black45,
          contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          title: new Text(
            key,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.4,
            ),
          ),

          value: temp[key],
          onChanged: (bool value) { // When checkbox is tapped, change its value on Firestore
            setState(() {
              _firestore
                  .collection("SpotlightUsers")
                  .doc(_auth.currentUser.uid)
                  .collection("WorkoutScheduler")
                  .doc("workout"+fullDate)
                  .update({key: value});
              temp[key] = value;
            });
          },
        );
      }).toList(),
    );
  }

  // Assigns a bool based on workout/date (Unused)
  /*
  Future<bool> getWorkoutBoxes(context, date, workout) async{
    var collection = await _firestore
        .collection("SpotlightUsers")
        .doc(_auth.currentUser.uid)
        .collection("WorkoutScheduler")
        .doc("workout"+date).get();
    try {
      bool temp = await collection.data()[workout];
      print(temp);
      return temp;
    } catch(e) {
      createBoxesDoc(date, workout);
      return false;
    }
  }*/

  /* Workout Notes */

  // Sets/Creates a Workout Notes Section for the given day
  void createNotesDoc(date) async {
    await _firestore
        .collection("SpotlightUsers")
        .doc(_auth.currentUser.uid)
        .collection("WorkoutScheduler")
        .doc("workout"+date)
        .set({"notes": "Enter workout notes here."}, SetOptions(merge: true));
  }

  // Creates an Updatable text field that can span up to 10 lines
  TextField buildTextFieldMultiLine(String labelText, String placeholder,
      String database, String date) {

    return TextField(
      onChanged: (text) {
        _firestore
            .collection("SpotlightUsers")
            .doc(_auth.currentUser.uid)
            .collection("WorkoutScheduler")
            .doc("workout"+date)
            .update({"notes": text});
      },
      maxLength: null,
      maxLines: 10,
      minLines: 1,
      style: TextStyle(
          fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white70),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 2, top: 10),
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: placeholder,
        labelStyle: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red[400]),
        hintStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white70,
        ),
      ),
    );
  }

  // Creates a multi-lined text field for workout notes
  Widget getWorkoutNotes(context, snapshot, date) {
    var workoutNotes;
    try {
      workoutNotes = snapshot.data['notes'];
    }
    // this is to get around having to use future instances
    // so as a workaround I am trying to get the notes from firebase
    // and if the notes for that day don't exist in firebase yet
    // a null error is thrown. we catch the error in this block then instead
    // of terminating the program we create the missing doc in firebase
    catch (e) {
      // this is to set the collection/docID if it was not found in the
      // try block. Once set, then workoutNotes is set to the data from
      // the new field, which is place holder/user hint text
      createNotesDoc(date);
      workoutNotes = "Enter workout notes here.";
    }

    var args = ModalRoute
        .of(context)
        .settings
        .arguments;

    if(workoutNotes == null){
      workoutNotes = "";
    }
    return Column(
        children: [
          // Sets field with notes for the given day if it exists in the database
          buildTextFieldMultiLine
            ("Workout Notes: ", workoutNotes, "workoutNotes",
              args.toString().substring(0, 10)),
          SizedBox(
            height: 10,
          )
        ]
    );
  }

  /* Build method for the page */

  Widget build(BuildContext context) {
    var args = ModalRoute
        .of(context)
        .settings
        .arguments;

    // Sets date field for tapped calendar date
    var today = formatDate(
        DateTime.parse(args.toString().substring(0, 10)), [MM, ' - ', dd]);

    var fullDate = args.toString().substring(0, 10); //Month/day/year

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Center(
          child: Text(
              today + ' Workout',
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
      ),

      body:
      ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Row(  // Houses Workout Checkbox Widgets
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible( // Workouts Group 1
                child: Container(
                  constraints: BoxConstraints.expand(
                      height: Theme.of(context).textTheme.headline4.fontSize * 1 + 300.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    boxShadow: [
                      BoxShadow(color: Colors.white, spreadRadius: 3),
                    ],
                  ),

                  color: Colors.amberAccent[600],
                  child: ListTileTheme(
                    textColor: Colors.black,
                    tileColor: Colors.redAccent,
                    child: FutureBuilder(
                        future: getWorkoutScheduler(fullDate),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return getWorkouts(context, snapshot, fullDate, 1);
                          }
                          else {
                            return CircularProgressIndicator(backgroundColor: Colors.red);
                          }
                        }
                    ),
                  ),
                ),
              ),

              Flexible( // Workouts Group 2
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    boxShadow: [
                      BoxShadow(color: Colors.white, spreadRadius: 3),
                    ],
                  ),
                  constraints: BoxConstraints.expand(
                    height: Theme.of(context).textTheme.headline4.fontSize * 1 + 300.0,
                  ),

                  color: Colors.amberAccent[600],
                  child: ListTileTheme(
                    textColor: Colors.black,
                    tileColor: Colors.redAccent,
                    child: FutureBuilder(
                        future: getWorkoutScheduler(fullDate),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return getWorkouts(context, snapshot, fullDate, 2);
                          }
                          else {
                            return CircularProgressIndicator(backgroundColor: Colors.red);
                          }
                        }
                    ),
                  ),
                ),
              ),
            ],
          ),

          Flexible( // Workout Notes
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: FutureBuilder(
                    future: getWorkoutScheduler(fullDate),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return getWorkoutNotes(context, snapshot, fullDate);                }
                      else {
                        return CircularProgressIndicator(backgroundColor: Colors.red,);
                      }
                    }
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}