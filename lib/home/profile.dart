import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotlight_login/constants.dart';
import 'package:url_launcher/url_launcher.dart';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Center(
          child: Container(
              child: Text(
                "Welcome " + loggedInUser.email,
                style: kLoginTextStyle,
              )
          ),
        ),
        Center(
          child: Container(
            child: InkWell(
                child: Text("It's time to be someone at the Gym!",
                  style: kLoginTextStyle,
                ),
                onTap: () => launch('https://nullpointerexception.greenriverdev.com/Spotlight/index.php')
            ),
          ),
        ),
        Image(
          image: AssetImage('assets/images/gym5.jpg'),
        ),
      ],
    );
  }
}