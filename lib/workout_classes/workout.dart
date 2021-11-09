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

final _auth = FirebaseAuth.instance;
var firebaseUser = FirebaseAuth.instance.currentUser;
FirebaseFirestore _firestore = FirebaseFirestore.instance;

User loggedInUser;
var uid;

void initState() {
  getCurrentUser();
}

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

//get the current user UID
Future<String> getCurrentUID() async {
  return firebaseUser.uid;
}

//get the current user info
Future getAuthUserInfo() async {
  return firebaseUser;
}

Future getFirestoreUser() async {
  return _firestore.collection("SpotlightUsers").doc(firebaseUser.uid).get();
}

Future getWorkoutScheduler(date) async {

  var doc = await _firestore
      .collection("SpotlightUsers")
      .doc(firebaseUser.uid)
      .collection("WorkoutScheduler").doc("workout"+date).get();

  if(doc.exists){
    return _firestore
        .collection("SpotlightUsers")
        .doc(firebaseUser.uid)
        .collection("WorkoutScheduler")
        .doc("workout"+date)
        .get();
  }
}

class _WorkoutState extends State<Workout> {
  @override
  final _auth = FirebaseAuth.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User loggedInUser;
  var uid;

  Map<String, bool> workouts = {
    'Biceps': false,
    'Shoulders': false,
    'Triceps': false,
    'Chest': false,
    'Back': false,
    'Legs': false,
  };

  Widget getWorkoutNotes(context, snapshot, user, date) {
    //loggedInUser = _auth.currentUser;
    // var workoutNotes = _firestore
    //     .collectionGroup("WorkoutScheduler")
    //     .get()
    //     .then((value) => value.data()["notes"])
    var workoutNotes = snapshot.data;
    workoutNotes = workoutNotes["notes"];

    // Future<dynamic> doesDayPlanExist(String date) async {
    //   try {
    //
    //     var workoutNotes = await _firestore
    //         .collection("SpotlightUsers")
    //         .doc(_auth.currentUser.uid)
    //         .collection("WorkoutScheduler")
    //         .doc("workout"+date)
    //         .get()
    //         .then((value) => value.data()["notes"]);
    //
    //     return workoutNotes;
    //   } catch (e) {
    //     throw e;
    //   }
    // }
    // workoutNotes = doesDayPlanExist(date);
    // if(_firestore
    //      .collection("SpotlightUsers")
    //      .doc(_auth.currentUser.uid)
    //      .collection("WorkoutScheduler")
    //      .doc("workout"+date).get() != null) {
    //   workoutNotes = "true";
    // }
    // else{
    //   workoutNotes = "false";
    // }

    var args = ModalRoute
        .of(context)
        .settings
        .arguments;

    if(workoutNotes == null){
      workoutNotes = "";
    }
    return Column(
        children: [
          buildTextFieldMultiLine
            ("Workout Notes: ", workoutNotes, "workoutNotes",
              args.toString().substring(0, 10)),
          SizedBox(
            height: 10,
          )
        ]
    );
  }

  Widget build(BuildContext context) {
    var args = ModalRoute
        .of(context)
        .settings
        .arguments;
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
          Container(
            constraints: BoxConstraints.expand(
              height: Theme.of(context).textTheme.headline4.fontSize * 1 + 300.0
            ),
          // height: 350,
          color: Colors.amber[600],
          // child: const Center(child: Text('Entry A')),
          child: ListTileTheme(
            textColor: Colors.black,
            tileColor: Colors.redAccent,
            child: ListView(
              children: workouts.keys.map((String key) {
                return new CheckboxListTile(
                  checkColor: Colors.black,
                  contentPadding: EdgeInsets.fromLTRB(30, 0, 250, 0),
                  title: new Text(key),
                  value: workouts[key],
                  onChanged: (bool value) {
                    setState(() {
                      workouts[key] = value;
                    });
                  },
                );
              }).toList(),
            ),
          ),
        ),
            Flexible(
      // constraints: BoxConstraints.expand(
      //   height: Theme.of(context).textTheme.headline4.fontSize * 1 + 300.0
      // ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: FutureBuilder(
            future: getWorkoutScheduler(fullDate),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                return getWorkoutNotes(context, snapshot, loggedInUser, fullDate);
                }
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

    // ListTileTheme(
    //       textColor: Colors.black,
    //       tileColor: Colors.redAccent,
    //
    //     child: ListView(
    //       children: workouts.keys.map((String key) {
    //         return new CheckboxListTile(
    //           checkColor: Colors.black,
    //           contentPadding: EdgeInsets.fromLTRB(30, 0, 250, 0),
    //           title: new Text(key),
    //           value: workouts[key],
    //           onChanged: (bool value) {
    //             setState(() {
    //               workouts[key] = value;
    //             });
    //           },
    //         );
    //       }).toList(),
    //     ),
    // ));


    // Center(
    //   child: Padding(
    //   padding: EdgeInsets.only(left: 25, right: 25),
    //   child: FutureBuilder(
    //       future: getFirestoreUser(),
    //       builder: (context, snapshot) {
    //         if (snapshot.connectionState == ConnectionState.done) {
    //           return getWorkoutNotes(context, snapshot, loggedInUser);
    //         } else {
    //           return CircularProgressIndicator(
    //             backgroundColor: Colors.red,
    //           );
    //         }
    //       }),
    //   ),
    // ),
    );
  }

  TextField buildTextFieldMultiLine(String labelText, String placeholder,
      String database, String date) {
    var user = _firestore
        .collection("SpotlightUsers")
        .doc(_auth.currentUser.uid)
        .collection("WorkoutScheduler")
        .doc("workout"+date);

    return TextField(
      onChanged: (text) {
        // if(_firestore
        //     .collection("SpotlightUsers")
        //     .doc(_auth.currentUser.uid)
        //     .collection("WorkoutScheduler")
        //     .doc("workout"+date) != null)
        //   {
            _firestore
                .collection("SpotlightUsers")
                .doc(_auth.currentUser.uid)
                .collection("WorkoutScheduler")
                .doc("workout"+date)
                .update({"notes": text});
          //}
        // else
        //   {
        //     _firestore
        //         .collection("SpotlightUsers")
        //         .doc(_auth.currentUser.uid)
        //         .collection("WorkoutScheduler")
        //         .doc("workout"+date)
        //         .set(
        //       {
        //         'notes':
        //       }
        //     );
        //   }

        //print(text)
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
}