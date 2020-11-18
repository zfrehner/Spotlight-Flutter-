import 'package:flutter/material.dart';



// for the login page
const kLoginTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 16.0,
    fontWeight: FontWeight.bold
);

const kErrorTextStyle = TextStyle(
  color: Colors.redAccent,
  fontSize: 15.0,
);

var kSignUpBoxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
          color: Colors.black26,
          blurRadius: 6,
          offset: Offset(0,2)
      ),]
);