
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotlight_login/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:intl/intl.dart';

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

  getName() {
    return _firestore
        .collection("SpotlightUsers")
        .doc(loggedInUser.uid) //"7uUbB9zLN7hyqPGiDpQjb3onWf73"
        .get()
        .then((value) => print(value.data()["firstName"]));
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

  Widget displayUserInfo(context, snapshot) {
    final user = snapshot.data;
    //final authUser = getAuthUserInfo();
    var phone = user["phoneNumber"];
    if(phone == null) {
      phone = "";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("First Name: ${user["firstName"]}",
            style: kLoginTextStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Last Name: ${user["lastName"]}",
              style: kLoginTextStyle),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Email: ${user["email"]}",
              style: kLoginTextStyle),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Phone: $phone",//{user["phoneNumber"]}
              style: kLoginTextStyle),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Birthday: ${DateFormat('MM/dd/yyyy').format(user["birthday"].toDate())}",
              style: kLoginTextStyle),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Gender: ${user["gender"]}",
              style: kLoginTextStyle),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Address: ${user["address"]}",
              style: kLoginTextStyle),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("City: ${user["city"]}",
              style: kLoginTextStyle),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Sate: ${user["state"]}",
              style: kLoginTextStyle),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Postal Code: ${user["zipCode"]}",
              style: kLoginTextStyle),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Country: ${user["country"]}",
              style: kLoginTextStyle),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                  children: <Widget> [FutureBuilder(
                      future: getFirestoreUser(),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.done) {
                          return Text("Welcome ${snapshot.data["firstName"].toUpperCase() + "!"}",
                              style: kLoginTextStyle);
                          /*Text("${snapshot.data.email}",
                      style: kLoginTextStyle)*/
                        }
                        else {
                          return CircularProgressIndicator(
                            backgroundColor: Colors.red,
                          );
                        }
                      }
                  ),
                  ]),
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
              Column(
                children: [
                  CircleAvatar(
                      backgroundImage: AssetImage('assets/images/gym5.jpg'),
                      radius: 100
                  ),
                ],
              ),
              Center(
                  child: FutureBuilder(
                      future: getFirestoreUser(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return displayUserInfo(context, snapshot);
                        } else {
                          return CircularProgressIndicator(
                            backgroundColor: Colors.red,
                          );
                        }
                      })
              ),
            ]));
  }
}