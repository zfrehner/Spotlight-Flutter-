import 'package:cloud_firestore/cloud_firestore.dart';

class SpotUser {
  var firstName;
  var lastName;
  var country;
  var address;
  var city;
  var state;
  var zipCode;
  var password;
  var email;
  var gender;
  var phoneNumber;
  var dateTime;//age

  SpotUser({this.firstName, this.lastName, this.email, this.password, this.gender,
      this.dateTime, this.country, this.address, this.city, this.state, this.zipCode,
  this.phoneNumber});

  // creating a Trip object from a firebase snapshot
  SpotUser.fromSnapshot(DocumentSnapshot snapshot) :
        firstName = snapshot.data()["firstName"].toString(),
  lastName = snapshot.data()["lastName"],
  country = snapshot.data()["country"],
  address = snapshot.data()["address"],
  city = snapshot.data()["state"],
  state = snapshot.data()["state"],
  zipCode = snapshot.data()["zipCode"],
  email = snapshot.data()["email"],
  gender = snapshot.data()["gender"],
  phoneNumber = snapshot.data()["phoneNumber"],
  dateTime = snapshot.data()["birthday"]; //age

  /*Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'country': country,
    'address': address,
    'city': city,
    'state': state,
    'zipCode': zipCode,
    'birthday': dateTime,
    'gender': gender,
    'phoneNumber': phoneNumber,
    'password' : password
  };*/
}