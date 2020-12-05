import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class ForgotPassword extends StatefulWidget {

  static const String id = 'forgot_password_screen';

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();

}

class _ForgotPasswordState extends State<ForgotPassword> {

  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;

  // **************** artems code: var *****************************************
  // creating a global key for use for the form
  var _formKey = GlobalKey<FormState>();
  // ***************************************************************************

  //*********************** Email Widget *****************************************
  Widget buildEmail() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Email',
            style: kLoginTextStyle,
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0,2)
                  ),
                ]
            ),
            height: 60,
            child: TextFormField(
                onChanged: (value){
                  email = value;
                },
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  color: Colors.black87,
                ),
                // **************** artems code : validation ***********************
                validator: (value) {
                  if (value.isEmpty) {
                    return "Email field cant be empty";
                  }
                  return null;
                },
                // *****************************************************************
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon: Icon(
                        Icons.email,
                        color: Color(0xffFF3232)
                    ),
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      color: Colors.black38,
                    ),
                    // **************** artems code: errorStyle ********************
                    errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15)
                  // *************************************************************
                )
            ),
          )
        ]
    );
  }

  //***************************Send Request Button ****************************
  Widget sendRequest() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RaisedButton(
          color: Colors.red,
          child: Text("Send Request",
            style: kLoginTextStyle,
           ),
          onPressed: () {
            _auth.sendPasswordResetEmail(email: email);
            Navigator.of(context).pop();
          }
        )
      ],
    );
  }

  //***************************** MAIN SCAFFOLD **********************************
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
          color: Colors.white,
          inAsyncCall: showSpinner,
          child: SafeArea(
            child: Form(
              key: _formKey,
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
                                          Hero(
                                            tag: 'logo',
                                            child: CircleAvatar(
                                              radius: 75,
                                              backgroundImage: AssetImage('assets/images/LOGO 4.jpg'),
                                            ),
                                          ),
                                          TypewriterAnimatedTextKit(
                                              text: ['SPOTLIGHT'],
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 40,
                                                fontWeight: FontWeight.bold,

                                              )
                                          ),
                                          Text(
                                              "It's time to be someone at the gym!",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold
                                              )
                                          ),
                                          SizedBox(height: 20),
                                          buildEmail(),
                                          SizedBox(height: 20),
                                          sendRequest()

                                        ]
                                    )
                                )
                            )
                          ]
                      )
                  )
              ),
            ),
          ),
        )
    );
  }

}