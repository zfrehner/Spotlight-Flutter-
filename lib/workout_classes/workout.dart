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

  Widget getWorkoutNotes(context, snapshot, user) {
    // loggedInUser = _auth.currentUser;
    var workoutNotes = "Multi-line text sample. This text is to visualize what "
        "the free text field in the calendar workout page will look on the same screen as the workout type checkboxes.";

    //     stream: _firestore.collection("SpotlightUsers").snapshots(),
    //     .collection("SpotlightUsers")
    //     .doc(_auth.currentUser.uid)
    //     .collection("WorkoutNotes")
    //     .doc("lBJwCxosn5TONAODxmDb");
    // if (workoutNotes == null) {
    //   workoutNotes = "";
    // }

    StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("Gyms").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ));
          }
          final gyms = snapshot.data.docs;


          // for (var gym in gyms) {
          //   final gymTitle = gym.data()["Title"];
          //   final gymAddress = gym.data()["Address"];
          //   final gymCity = gym.data()["City"];
          //   final gymUsers = gym.data()["NumUsers"];
          //
          //   final gymWidget = GymDisplay(
          //       title: gymTitle, address: gymAddress, city: gymCity,
          //       numUsers: gymUsers);
          //
          //   gymWidgets.add(gymWidget);
          // }

          //return the styling that we want here (Cards)
          return Expanded(
            child: ListView(
              padding:
              EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              // children: gymWidgets,
            ),
          );
        });

    var args = ModalRoute
        .of(context)
        .settings
        .arguments;

    return Column(
        children: [
          buildTextFieldMultiLine
            ("Workout Notes: ", "$workoutNotes", "workoutNotes",
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
    future: getFirestoreUser(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
    return getWorkoutNotes(context, snapshot, loggedInUser);
    } else {
    return CircularProgressIndicator(
    backgroundColor: Colors.red,
    );
    }
    }),
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
    return TextField(
      onChanged: (text) {
        _firestore
            .collection("SpotlightUsers")
            .doc(_auth.currentUser.uid)
            .collection("WorkoutNotes")
            .doc(date)
            .update({database: text});
        //print(text)
      },
      maxLength: null,
      maxLines: null,
      minLines: 5,
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