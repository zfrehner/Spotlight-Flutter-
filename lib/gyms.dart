import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotlight_login/constants.dart';

class Gyms extends StatefulWidget {
  @override
  _GymsState createState() => _GymsState();
}

class _GymsState extends State<Gyms> {
  final _auth = FirebaseAuth.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User loggedInUser;

  void initState() {
    getCurrentUser();
  }

  /*void gymStream() async {
    await for(var snapshot in _firestore.collection("Gyms").snapshots()) {
      for(var info in snapshot.docs) {
        print(info.data());
      }
    }
  }*/

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;

      if (user != null) {
        loggedInUser = user;
        //print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text(
        "Spotlight Gyms",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
      ),
      Expanded(
        child: Center(
          child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection("Gyms").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ));
                }
                final gyms = snapshot.data.docs;
                List<GymDisplay> gymWidgets = [];

                for (var gym in gyms) {
                  final gymTitle = gym.data()["Title"];
                  final gymAddress = gym.data()["Address"];
                  final gymCity = gym.data()["City"];
                  final gymUsers = gym.data()["NumUsers"];
                  //final gymNumUsers = gym.data()["NumUsers"];
                  final gymWidget = GymDisplay(
                      title: gymTitle, address: gymAddress, city: gymCity,
                  numUsers: gymUsers);

                  gymWidgets.add(gymWidget);
                }
                //return the styling that we want here (Cards)
                return Expanded(
                  child: ListView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: gymWidgets,
                  ),
                );
              }),
        ),
      ),
    ]);
  }
}

class GymDisplay extends StatelessWidget {
  GymDisplay({this.title, this.address, this.city, this.numUsers}); //, this.numUsers

  final String title;
  final String address;
  final String city;
  final int numUsers;

  //final int numUsers;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 10,
        color: Colors.red,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$title",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0, left: 8.0),
              child: Row(
                children: [
                  Text(
                    "$address",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
              child: Row(
                children: [
                  Text(
                    "$city",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.how_to_reg),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(": $numUsers",
                    style: kLoginTextStyle),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*class GymDisplay extends StatelessWidget {

  GymDisplay({this.title, this.address});//, this.numUsers

  final String title;
  final String address;
  //final int numUsers;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Material(
        borderRadius: BorderRadius.circular(30),
        elevation: 10,
        color: Colors.red,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            "$title \nAddress: $address",// \nSpotlight Users: $numUsers
            style: kLoginTextStyle,
          ),
        ),
      ),
    );
  }
}*/

/*return new ListView(
padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
scrollDirection: Axis.vertical,
shrinkWrap: true,
children: gymWidgets,
);*/

/*Widget build(BuildContext context) {
  return Container(
    child: Card(
      elevation: 10,
      color: Colors.red,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$title",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Text(
                  "$address",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "$city",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    ),
  );

}
}*/
