import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';

final _auth = FirebaseAuth.instance;  // Firebase Authentication Instance
var firebaseUser = FirebaseAuth.instance.currentUser; // The current App User
FirebaseFirestore _firestore = FirebaseFirestore.instance;  // Firebase Firestore Instance

// Creates a textbox on the calendar page with the given day's workout notes
Widget displayWorkoutNotes(context, snapshot, date) {

  // Gets workout notes if they exist, otherwise sets to a default in the catch
  var workoutNotes = snapshot.data;
  try{
    workoutNotes = snapshot.data["notes"];
    // Replace with future builder using _firestore to get a new instance thingimabob

    // (Not sure if the above note is still relevant, feel free to ignore it)
  }catch(e){
    workoutNotes = "New schedule made for this day";
  }

  // Formats current date
  String currentDate = formatDate(date,[MM,' - ', dd]);

  // Returns the textbox Widget
  return Column(
      children: [
        FractionallySizedBox(
          widthFactor: 1,
          child: Theme(
            data: ThemeData.from(
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber),
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 7, 0, 0),
              child: Text("Workout Notes: "+currentDate+"\n"
                  +workoutNotes,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.4,
              ),),
              decoration: BoxDecoration(color: Theme.of(context).backgroundColor
                  ,border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              // color: Theme.of(context).backgroundColor
            ),
          )
        )

        // ),
      ],

  );
}

// Creates an Updatable text field that can span up to 10 lines (Unused in Calendar Page)
TextField buildTextFieldMultiLine(String labelText, String placeholder,
    String database, String date) {


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