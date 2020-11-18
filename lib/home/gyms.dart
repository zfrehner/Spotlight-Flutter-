import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotlight_login/constants.dart';
import 'package:url_launcher/url_launcher.dart';


class Gyms extends StatefulWidget {
  @override
  _GymsState createState() => _GymsState();
}

class _GymsState extends State<Gyms> {

  final _auth = FirebaseAuth.instance;
  var firebaseUser =  FirebaseAuth.instance.currentUser;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User loggedInUser;

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

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[ Text(
            "Gyms",
            style: kLoginTextStyle,
        ),
          Center(
            child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection("Gyms").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final gyms = snapshot.data.docs;
                    List<Text> gymWidgets = [];
                    for (var gym in gyms) {
                      final gymAddress = gym.data()["Address"];
                      final gymNumUsers = gym.data()["NumUsers"];
                      final gymWidget = Text(
                          "$gymAddress has $gymNumUsers Spotlight Users",
                        style: kLoginTextStyle,
                      );
                      gymWidgets.add(gymWidget);
                    }
                    return Column(
                        children: gymWidgets
                    );
                  }
                  return null;
                }
            ),
          ),
        ]);
  }
}



