import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotlight_login/constants.dart';

/// Recommended: Find a way to combine the GymView files into a single GymView file

class GymCardFourView extends StatefulWidget {
  static const String id = 'gym_card_four_view';
  @override
  _GymCardFourViewState createState() => _GymCardFourViewState();
}

class _GymCardFourViewState extends State<GymCardFourView> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  User loggedInUser;
  var userID;

  // Future<String> getFirstName() {
  //   return _firestore
  //       .collection("SpotlightUsers")
  //       .doc(loggedInUser.uid) //"7uUbB9zLN7hyqPGiDpQjb3onWf73"
  //       .get()
  //       .then((value) => (value.data()["firstName"]));
  //
  // }
  //
  // Future<String> getLastName() {
  //   return _firestore
  //       .collection("SpotlightUsers")
  //       .doc(loggedInUser.uid) //"7uUbB9zLN7hyqPGiDpQjb3onWf73"
  //       .get()
  //       .then((value) => ( value.data()["lastName"]));
  // }

  Future<String> getUsername(){
    return _firestore
        .collection("SpotlightUsers")
        .doc(loggedInUser.uid)
        .get()
        .then((value) => (value.data()["username"]));
  }

  Future<String> getGender()  {
    return _firestore
        .collection("SpotlightUsers")
        .doc(loggedInUser.uid) //"7uUbB9zLN7hyqPGiDpQjb3onWf73"
        .get()
        .then((value) => (value.data()["gender"]));
  }

  Future<DateTime> getBirthday() {

    return  _firestore
        .collection("SpotlightUsers")
        .doc(loggedInUser.uid) //"7uUbB9zLN7hyqPGiDpQjb3onWf73"
        .get()
        .then((value) => (value.data()["birthday"]).toDate());

  }

  Future<int> getNumUsers() {
    return _firestore.collection("Gyms").doc("Gym 4").get()
        .then((value) => (value.data()["NumUsers"]));
  }

  Future<String> getHobbies() {
    return _firestore.collection("SpotlightUsers")
        .doc(loggedInUser.uid)
        .get()
        .then((value) => (value.data()["hobbies"]));
  }

  Future<String> getWorkout() {
    return _firestore.collection("SpotlightUsers")
        .doc(loggedInUser.uid)
        .get()
        .then((value) => (value.data()["workout"]));
  }

  void initState() {
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      final fireUser = FirebaseAuth.instance.currentUser.uid;

      if (user != null) {
        loggedInUser = user;
        userID = fireUser;

        //print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Future getFirestoreUser() async {
    return _firestore.collection("SpotlightUsers").doc(firebaseUser.uid).get();
  }

  //******************************* Show Dialogue Box ****************************
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Spotlight Notice!'),
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You are already checked in!'),
                Text('Please check out first.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Continue'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //***************************Show Dialog 2 Box  ***********************
  Future<void> _showMyDialog2() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Spotlight Notice!'),
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You are NOT checked in!'),
                Text('Please check-in first.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Continue'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    //do something
                  },
                  icon: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/LOGO 4.jpg'),
                  )
              ),
              centerTitle: true,
              title: Center(
                  child: Text('SPOTLIGHT',
                      style: TextStyle(fontSize: 30.0))
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.close_rounded),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            body: Column(children: <Widget>[
              // title and address text
              Text(
                "Good Life Fitness #4\n" +
                    "7700 Keele St Concord, ON L4K 2A1\n",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),

              // People checked-in text
              Text(
                "People checked-in to Gym 4!",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ), Expanded(
                child: Column(
                    children: <Widget>[StreamBuilder<QuerySnapshot>(
                        stream: _firestore.collection("Gym4CheckedIn").snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                ));
                          }
                          final users = snapshot.data.docs;
                          List<UserDisplay> userWidgets = [];

                          for (var user in users) {
                            final username = user.data()["Username"];
                            final userGender = user.data()["Gender"];
                            final userAge = user.data()["Age"];
                            final userHobbies = user.data()["Hobbies"];
                            final userFavWorkout = user.data()["Workout"];


                            final gymWidget = UserDisplay(
                                username: username, gender: userGender, age: userAge,
                                hobbies: userHobbies, workout: userFavWorkout);

                            userWidgets.add(gymWidget);
                          }

                          //return the styling that we want here (Cards)
                          return Expanded(
                            child: ListView(
                              padding:
                              EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: userWidgets,
                            ),
                          );

                        }),
                    ]),
              ),
              Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Remember to check-in and check out!",
                          style: kLoginTextStyle),
                    )
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        heroTag: "check-in",
                        onPressed: () async {
                          // var first = await getFirstName();
                          // var last = await getLastName();
                          var username = await getUsername();
                          var gender = await getGender();
                          var hobbies = await getHobbies();
                          var workout = await getWorkout();
                          // Find out your age
                          var birthday = await getBirthday();

                          DateTime today = DateTime.now();
                          Duration dur = today.difference(birthday);

                          String differenceInYears = (dur.inDays/365).floor().toString();

                          final user = await _firestore.collection("Gym1CheckedIn")
                              .doc(_auth.currentUser.uid).get();

                          final user2 = await _firestore.collection("Gym2CheckedIn")
                              .doc(_auth.currentUser.uid).get();

                          final user3 = await _firestore.collection("Gym3CheckedIn")
                              .doc(_auth.currentUser.uid).get();

                          final user4 = await _firestore.collection("Gym4CheckedIn")
                              .doc(_auth.currentUser.uid).get();

                          var count = await getNumUsers();

                          if(!user.exists && !user2.exists && !user3.exists && !user4.exists) {
                            //check the user into the gym by adding info to new collection
                            _firestore.collection("Gym4CheckedIn")
                                .doc(_auth.currentUser.uid)
                                .set({
                              "Username": username,
                              "Gender": gender,
                              "Age": differenceInYears,
                              "Hobbies" : hobbies,
                              "Workout" : workout
                            });

                            DateTime rightNow = DateTime.now();
                            var nowString = rightNow.toString().substring(0, 10);
                            _firestore
                                .collection("SpotlightUsers")
                                .doc(_auth.currentUser.uid)
                                .collection("WorkoutScheduler")
                                .doc("workout"+nowString)
                                .set({"workedOut": true}, SetOptions(merge: true));

                            _firestore.collection("Gyms")
                                .doc("Gym 4")
                                .update({
                              "NumUsers": count + 1
                            });
                          }
                          else {
                            _showMyDialog();
                          }

                        },
                        child: Icon(Icons.person_add),
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        heroTag: "check-out",
                        onPressed: () async{
                          final user = await _firestore.collection("Gym1CheckedIn")
                              .doc(_auth.currentUser.uid).get();

                          final user2 = await _firestore.collection("Gym2CheckedIn")
                              .doc(_auth.currentUser.uid).get();

                          final user3 = await _firestore.collection("Gym3CheckedIn")
                              .doc(_auth.currentUser.uid).get();

                          final user4 = await _firestore.collection("Gym4CheckedIn")
                              .doc(_auth.currentUser.uid).get();
                          //check the user out of the gym by deleting doc from collection
                          _firestore.collection("Gym4CheckedIn")
                              .doc(_auth.currentUser.uid)
                              .delete();

                          DateTime rightNow = DateTime.now();
                          var nowString = rightNow.toString().substring(0, 10);
                          _firestore
                              .collection("SpotlightUsers")
                              .doc(_auth.currentUser.uid)
                              .collection("WorkoutScheduler")
                              .doc("workout"+nowString)
                              .set({"workedOut": false}, SetOptions(merge: true));

                          //subtract 1 from the NumUsers in the gym
                          var count = await getNumUsers();
                          if(!user.exists && !user2.exists && !user3.exists && user4.exists) {
                            _firestore.collection("Gyms")
                                .doc("Gym 4")
                                .update({
                              "NumUsers": count - 1
                            });
                          }
                          else {
                            _showMyDialog2();
                          }
                        },
                        child: Icon(Icons.person_remove),
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                    )
                  ])
            ])));
  }
}

class UserDisplay extends StatelessWidget {
  UserDisplay({this.username, this.gender, this.age, this.hobbies, this.workout});

  final String username;
  final String gender;
  final String age;
  final String hobbies;
  final String workout;



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
                        "$username",
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
                        "Gender: $gender",
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
                  padding: EdgeInsets.only(top: 8.0, left: 8.0),
                  child: Row(
                    children: [
                      Text(
                        "Hobbies: $hobbies",
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
                  padding: EdgeInsets.only(top: 8.0, left: 8.0),
                  child: Row(
                    children: [
                      Text(
                        "Favorite Workout: $workout",
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
                        "Age: $age",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.person),
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