//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'loginPage.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:spotlight_login/signUpLast.dart';

class Success extends StatefulWidget {
  @override
  _SuccessState createState() => _SuccessState();
}
class _SuccessState extends State<Success> {

  Widget buildReturnBtn() {
    return GestureDetector(
        onTap: () =>
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            ),
        child: RichText(
            text: TextSpan(
                children: [
                  TextSpan(
                      text: 'Return to Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      )
                  )
                ]
            )
        )
    );
  }

  Widget buildSuccessMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 50.0, bottom: 50.0),
          child: Text('Thank you for signing up with SPOTLIGHT!',
              textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
            )
          ),
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: GestureDetector(
                  child: Stack(
                      children: <Widget>[
                        Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xffFF3232),
                                      Color(0xccFF3232),
                                      Color(0xccFF3232),
                                      Color(0xffFF3232),
                                    ]
                                )
                            ),
                            child: SingleChildScrollView(
                                physics: AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25,
                                    vertical: 25
                                ),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: 75,
                                        backgroundImage: AssetImage('assets/images/LOGO 4.jpg'),
                                      ),
                                      Text(
                                          'SPOTLIGHT',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,

                                          )
                                      ),
                                      SizedBox(height: 20),
                                      buildSuccessMessage(),
                                      SizedBox(height: 20),
                                      buildReturnBtn(),

                                    ]
                                )
                            )
                        )
                      ]
                  )
              )
          ),
        )
    );
  }
}