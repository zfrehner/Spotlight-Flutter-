

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
var firebaseUser = FirebaseAuth.instance.currentUser;
User loggedInUser;
var userID;

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



Future<String> getFirstName() {
    return _firestore
        .collection("SpotlightUsers")
        .doc(loggedInUser.uid) //"7uUbB9zLN7hyqPGiDpQjb3onWf73"
        .get()
        .then((value) => (value.data()["firstName"]));

  }

  Future<String> getLastName() {
    return _firestore
        .collection("SpotlightUsers")
        .doc(loggedInUser.uid) //"7uUbB9zLN7hyqPGiDpQjb3onWf73"
        .get()
        .then((value) => ( value.data()["lastName"]));
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
    return _firestore.collection("Gyms").doc("Gym 1").get()
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