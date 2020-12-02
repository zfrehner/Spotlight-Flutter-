import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotlight_login/constants.dart';
import 'package:spotlight_login/gymViews/gym1View.dart';


class GymCardView extends StatefulWidget {
  static const String id = 'gym_card_view';
  @override
  _GymCardViewState createState() => _GymCardViewState();
}

class _GymCardViewState extends State<GymCardView> {

  final _auth = FirebaseAuth.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User loggedInUser;

  void initState() {
    getCurrentUser();
  }

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

  List<GymDisplay> gymWidgets = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            //print("Hello");
          },
          icon: CircleAvatar(
            backgroundImage: AssetImage('assets/images/LOGO 4.jpg'),
          ),
        ),
        centerTitle: true,
        title: Center(
          child: Text(
              'SPOTLIGHT',
              style: TextStyle(fontSize: 30.0)
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Current number of people at each gym!",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
          ),
        ),
        Expanded(
          child: Column(
              children: <Widget>[StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection("Gyms").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ));
                    }
                    final gyms = snapshot.data.docs;


                    for (var gym in gyms) {
                      final gymTitle = gym.data()["Title"];
                      final gymAddress = gym.data()["Address"];
                      final gymCity = gym.data()["City"];
                      final gymUsers = gym.data()["NumUsers"];

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
              ]),
        ),
        Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 30),
            child: FloatingActionButton(
              onPressed: () {
                //navigate to the list view of gyms
                Navigator.pop(context);
              },
              child: Icon(Icons.map_rounded ),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            )
        )
      ]),
    ));
  }
}



class GymDisplay extends StatelessWidget {
  GymDisplay({this.title, this.address, this.city, this.numUsers});

  final String title;
  final String address;
  final String city;
  final int numUsers;


  @override
  Widget build(BuildContext context) {

    return
      Container(
        child: GestureDetector(
          onTap: () {
            //change to the index matching the card view

            //Navigator.pushNamed(context, GymCardOneView.id);

          },
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
        ),
      );
  }
}