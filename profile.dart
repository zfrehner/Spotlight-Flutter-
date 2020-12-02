import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
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

    // Variable to show empty strings instead of null
    // if user leaves any of these blanlk

    // check if phone is left blank
    var phone = user["phoneNumber"];
    if (phone == null) {
      phone = "";
    }
    // check if address is left blank
    var address = user["address"];
    if (address == null) {
      address = "";
    }
    // check if city is left blank
    var city = user["city"];
    if (city == null) {
      city = "";
    }
    // check if state is left blank
    var state = user["state"];
    if (state == null) {
      state = "";
    }
    // check if zipcode is left blank
    var zip = user["zipCode"];
    if (zip == null) {
      zip = "";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTextField("First Name", "${user["firstName"]}"),
        buildTextField("Last Name", "${user["lastName"]}"),
        buildTextField("Email", "${user["email"]}"),
        buildTextField("Phone", "$phone"),
        //buildTextField("Birthday", "${user["birthday"].toDate()}"),
        buildTextField("Address", "$address"),
        buildTextField("City", "$city"),
        buildTextField("State", "$state"),
        buildTextField("Postal code", "$zip"),
        buildTextField("Country", "${user["country"]}"),
        // extra fields for optional info
        buildTextField("Interests/Hobbies", ""),
        buildTextField("Favorite workout", ""),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(children: <Widget>[
                Row(children: [
                  FutureBuilder(
                      future: getFirestoreUser(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Expanded(
                              child: Center(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 7, 0, 0),
                              child: Text(
                                "Welcome ${snapshot.data["firstName"].toUpperCase() + "!"}",
                                style: TextStyle(
                                  fontSize: 25,
                                  //fontStyle: FontStyle.italic,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 2
                                    ..color = Colors.red[400].withOpacity(0.8),
                                ),
                              ),
                            ),
                          ));
                          /*Text("${snapshot.data.email}",
                      style: kLoginTextStyle)*/
                        } else {
                          return CircularProgressIndicator(
                            backgroundColor: Colors.red,
                          );
                        }
                      }),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Icon(
                      Icons.settings,
                    ),
                  ),
                ]),
              ]),
              Center(
                child: Container(
                  child: InkWell(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Text(
                          "It's time to be someone at the Gym!",
                          style: TextStyle(
                            fontSize: 20,
                            //fontStyle: FontStyle.italic,
                            foreground: Paint()
                              ..style = PaintingStyle.fill
                              ..color = Colors.red[400].withOpacity(0.8),
                          ),
                        ),
                      ),
                      onTap: () => launch(
                          'https://nullpointerexception.greenriverdev.com/Spotlight/index.php')),
                ),
              ),
              Center(
                child: Stack(
                  children: [
                    // CircleAvatar(
                    //     backgroundImage: AssetImage('assets/images/gym5.jpg'),
                    //     radius: 100),
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4, color: Colors.white.withOpacity(0.9)),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 3,
                                blurRadius: 6,
                                color: Colors.white)
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/gym5.jpg'))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.8),
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 3, color: Colors.white)),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ))
                  ],
                ),
              ),
              Center(
                  child: Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
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
                    }),
              )),
            ])
      ],
    );
  }

  TextField buildTextField(String labelText, String placeholder) {
    return TextField(
      onSubmitted: (text) {
        print(text);
      },
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
