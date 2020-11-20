import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotlight_login/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:spotlight_login/classes/SpotUser.dart';

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _auth = FirebaseAuth.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User loggedInUser;
  var uid;

  final SpotUser sUser;
  _ProfileState({Key key, @required this.sUser});


  void initState() {
    getCurrentUser();
  }

  void gymStream() async {
    await for (var snapshot in _firestore.collection("Gyms").snapshots()) {
      for (var info in snapshot.docs) {
        print(info.data());
      }
    }
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

  /*void _onPressed() {
    //var firebaseUser =  FirebaseAuth.instance.currentUser;
    getCurrentUser();
    //var userId = loggedInUser.email;
    var name = _firestore
        .collection("SpotlightUsers")
        .doc(loggedInUser.uid) //"7uUbB9zLN7hyqPGiDpQjb3onWf73"
        .get()
        .then((value) => print(value.data()["firstName"]));
    print(loggedInUser.email);
  }*/

 /* getName() {
    return _firestore
        .collection("SpotlightUsers")
        .doc(loggedInUser.uid) //"7uUbB9zLN7hyqPGiDpQjb3onWf73"
        .get()
        .then((value) => print(value.data()["firstName"]));
  }*/


String firstName;

  @override
  Widget build(BuildContext context) {


    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Center(
          child: Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection("SpotlightUsers").snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final users = snapshot.data.docs;
                      for (var SpotUser in users) {
                        print(SpotUser.data()["uid"]);
                        print(_auth.currentUser.uid);
                        if (SpotUser.data()["uid"] == _auth.currentUser.uid) {
                          //firstName = SpotUser.data()["firstName"];
                           SpotUser(
                            firstName : SpotUser.data()["firstName"].toString(),
                            lastName : SpotUser.data()["lastName"],
                            country : SpotUser.data()["country"],
                            address : SpotUser.data()["address"],
                              city : SpotUser.data()["state"],
                              state : SpotUser.data()["state"],
                              zipCode : SpotUser.data()["zipCode"],
                              email : SpotUser.data()["email"],
                              gender : SpotUser.data()["gender"],
                              phoneNumber : SpotUser.data()["phoneNumber"],
                              dateTime : SpotUser.data()["birthday"] //age
                           );

                          return Text(
                              "Welcome " +
                                  SpotUser.data()["firstName"].toString(),
                              style: kLoginTextStyle);
                        }
                      }
                    }
                    return Container();
                  })),
        ),
        Center(
          child: Container(
            child: InkWell(
                child: Text(
                  "It's time to be someone at the Gym!",
                  style: kLoginTextStyle,
                ),
                onTap: () => launch(
                    'https://nullpointerexception.greenriverdev.com/Spotlight/index.php')),
          ),
        ),
        Image(
          image: AssetImage('assets/images/gym5.jpg'),
        ),
        Column(children: <Widget>[
          Text("First Name: " +
              sUser.firstName +
                  "\n" +
                  "Last Name: " +
              sUser.lastName +
                  "\n" +
                  "Email: " +
              sUser.email +
                  "\n" +
                  "Phone Number: " +
              sUser.phoneNumber +
                  "\n" +
                  "Gender: " +
              sUser.gender +
                  "\n" +
                  "Birthday: " +
              sUser.dateTime +
                  "\n" +
                  "Address: " +
              sUser.address +
                  "\n" +
                  "City: " +
              sUser.city +
                  "\n" +
                  "State: " +
              sUser.state +
                  "\n" +
                  "Zip Code: " +
              sUser.zipCode +
                  "\n" +
                  "Country: " +
              sUser.country

              //style: kLoginTextStyle
              )
        ]),
      ],
    );
  }
}
