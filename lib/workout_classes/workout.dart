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
    'Triceps': false,
    'Chest': false,
    'Shoulders': false,
    'Back': false,
    'Legs': false,
  };

  Future<dynamic> assignWorkoutBool(context, date) async{
    workouts['Biceps'] = await getWorkoutBoxes(context, date, "Biceps");
    workouts['Shoulders'] = await getWorkoutBoxes(context, date, "Shoulders");
    workouts['Triceps'] = await getWorkoutBoxes(context, date, "Triceps");
    workouts['Chest'] = await getWorkoutBoxes(context, date, "Chest");
    workouts['Back'] = await getWorkoutBoxes(context, date, "Back");
    workouts['Legs'] = await getWorkoutBoxes(context, date, "Legs");
  }

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
  }

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  constraints: BoxConstraints.expand(
                      height: Theme.of(context).textTheme.headline4.fontSize * 1 + 300.0
                  ),

                  color: Colors.amberAccent[600],
                  child: ListTileTheme(
                    textColor: Colors.black,
                    tileColor: Colors.redAccent,
                    child: FutureBuilder(
                        future: getWorkoutScheduler(fullDate),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return getWorkouts(context, snapshot, fullDate);
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

          Flexible(
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

  void createNotesDoc(date) async {
    await _firestore
        .collection("SpotlightUsers")
        .doc(_auth.currentUser.uid)
        .collection("WorkoutScheduler")
        .doc("workout"+date)
        .set({"notes": "Enter workout notes here."}, SetOptions(merge: true));
  }

  void createBoxesDoc(date, workout) async {
    await _firestore
        .collection("SpotlightUsers")
        .doc(_auth.currentUser.uid)
        .collection("WorkoutScheduler")
        .doc("workout"+date)
        .set({workout: false}, SetOptions(merge: true));
  }

  bool getBoxes(BuildContext context, snapshot, String date, String workout) {
    try {
      return snapshot.data[workout];
    } catch(e) {
      createBoxesDoc(date, workout);
      return false;
    }
  }

  Widget getWorkouts(BuildContext context, snapshot, String fullDate) {
    for (String workoutName in workouts.keys) {
      workouts[workoutName] = getBoxes(context, snapshot, fullDate, workoutName);
    }

    return ListView(
      children: workouts.keys.map((String key) {
        return new CheckboxListTile(
          checkColor: Colors.white,
          activeColor: Colors.black45,
          contentPadding: EdgeInsets.fromLTRB(10, 0, 215, 0),
          title: new Text(
              key,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.4,
            ),
          ),

          value: workouts[key],
          onChanged: (bool value) {
            setState(() {
              _firestore
                  .collection("SpotlightUsers")
                  .doc(_auth.currentUser.uid)
                  .collection("WorkoutScheduler")
                  .doc("workout"+fullDate)
                  .update({key: value});
              workouts[key] = value;
            });
          },
        );
      }).toList(),
    );
  }
}