import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotlight_login/signUpPage.dart';
import 'package:spotlight_login/homePage.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'successPage.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {

  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {

  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;

  bool isChecked = false;

  // **************** artems code: var *****************************************
  // creating a global key for use for the form
  var _formKey = GlobalKey<FormState>();
  // ***************************************************************************

  Widget buildEmail() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Email',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),
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

  Widget buildPassword() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Password',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),
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
                  password = value;
                },
                  obscureText: true,
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                  // **************** artems code : validation ***********************
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Password field cant be empty";
                    }
                    return null;
                  },
                  // *****************************************************************
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14),
                      prefixIcon: Icon(
                          Icons.lock,
                          color: Color(0xffFF3232)
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: Colors.black38,
                      ),
    // ******************** artems code: errorStyle ****************
    errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15)),
    // *************************************************************
                  )
              )
        ]
    );
  }

  Widget buildForgotPassBtn() {
    return Container(
        alignment: Alignment.centerRight,
        child: FlatButton(
            onPressed: () => print("Forgot password was pressed"),
            padding: EdgeInsets.only(right: 0),
            child: Text(
                'Forgot Password?',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                )
            )
        )
    );
  }

  Widget buildRememberMeBox() {
    return Container(
        height: 20,
        child: Row(
            children: <Widget>[
              Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.white),
                  child: Checkbox(
                    value: isChecked,
                    checkColor: Colors.red,
                    activeColor: Colors.white,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value;
                      });
                    },
                  )
              ),
              Text(
                'Remember Me',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              )
            ]
        )
    );
  }

  Widget buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
          onPressed: () async {
          setState(() {
            showSpinner = true;
          });
          try {
            final user = await _auth.signInWithEmailAndPassword(
                email: email, password: password);
            if (user != null) {
              Navigator.pushNamed(context, LandPage.id);
            }
            setState(() {
              showSpinner = false;
            });
          }
          catch(e) {
            print(e);
          }
            /*setState(() {
              if (_formKey.currentState.validate()) {
                // if validate = true, take user to home screen
                Navigator.pushNamed(context, Success.id);
              }

            })*/;
          },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
          color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Colors.red,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          )
        )
      )
    );
  }

  Widget buildSignUpBtn() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, SignUpScreen.id),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Don't have an account?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              )
            ),
            TextSpan(
              text: ' Sign up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold
              )
            )
          ]
        )
      )
    );
  }

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
                            buildPassword(),
                            buildForgotPassBtn(),
                            buildRememberMeBox(),
                            buildLoginBtn(),
                            buildSignUpBtn()
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

