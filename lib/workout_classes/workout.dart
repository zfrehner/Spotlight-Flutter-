
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'workouts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:spotlight_login/max_lengths_formatter.dart';
import 'package:intl/intl.dart';


class Workout extends StatefulWidget {
  static const String route = '/workout';
  static const String id = "workout";
  @override
  _WorkoutState createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  @override
  final _auth = FirebaseAuth.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User loggedInUser;
  var uid;

  Map<String, bool> workouts = {
    'Biceps':false,
    'Shoulders':false,
    'Triceps':false,
    'Chest':false,
    'Back':false,
    'Legs':false,

  };

  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    var today = formatDate(DateTime.parse(args.toString().substring(0,10)),[MM,' - ',dd]);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Center(
          child: Text(
               today+' Workout',
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
          ListTileTheme(
              textColor: Colors.black,
              tileColor: Colors.redAccent,

              child: ListView(
                children: workouts.keys.map((String key) {
                  return new CheckboxListTile(
                    checkColor: Colors.black,
                    contentPadding: EdgeInsets.fromLTRB(30, 0, 250, 0),
                    title: new Text(key),
                    value: workouts[key],
                    onChanged: (bool value){
                      setState(() {
                        workouts[key] = value;
                      });
                    },
                  );
                }).toList(),
              )
          )
    );
  }
  TextField buildTextFieldMultiLine(
      String labelText, String placeholder, String database) {
    return TextField(
      onChanged: (text) {
        _firestore
            .collection("SpotlightUsers")
            .doc(_auth.currentUser.uid)
            .update({database: text});
        //print(text)
      },
      maxLength: null,
      maxLines: null,
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
      inputFormatters: [
      ],
    );
  }
}