import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotlight_login/signUpContinue.dart';


class SignUpScreen extends StatefulWidget {

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

Widget buildFirstNameField() {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'First Name',
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
          child: TextField(
              /*keyboardType: TextInputType.emailAddress,*/
              style: TextStyle(
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(
                      Icons.person,
                      color: Color(0xffFF3232)
                  ),
                  hintText: 'First Name',
                  hintStyle: TextStyle(
                    color: Colors.black38,
                  )
              )
          ),
        )
      ]
  );
}

Widget buildLastNameField() {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Last Name',
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
              /*keyboardType: TextInputType.emailAddress,*/
              style: TextStyle(
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(
                      Icons.person,
                      color: Color(0xffFF3232)
                  ),
                  hintText: 'Last Name',
                  hintStyle: TextStyle(
                    color: Colors.black38,
                  )
              )
          ),
        )
      ]
  );
}

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
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: Colors.black87,
              ),
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
                  )
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
                obscureText: true,
                style: TextStyle(
                  color: Colors.black87,
                ),
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
                    )
                )
            )
        )
      ]
  );
}

Widget buildConfirmPassword() {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Confirm Password',
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
                obscureText: true,
                style: TextStyle(
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon: Icon(
                        Icons.lock_open,
                        color: Color(0xffFF3232)
                    ),
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(
                      color: Colors.black38,
                    )
                )
            )
        )
      ]
  );
}

Widget buildContinueBtn() {
  return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUpContinue()),
      ),
      child: RichText(
          text: TextSpan(
              children: [
                TextSpan(
                    text: 'Continue',
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 40),
                                          child: Text(
                                              'Sign Up',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                              )
                                          ),
                                        ),
                                        CircleAvatar(
                                          radius: 50,
                                          backgroundImage: AssetImage('assets/images/LOGO 4.jpg'),

                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 10),
                                    buildFirstNameField(),
                                    SizedBox(height: 10),
                                    buildLastNameField(),
                                    SizedBox(height: 10),
                                    buildEmail(),
                                    SizedBox(height: 10),
                                    buildPassword(),
                                    SizedBox(height: 10),
                                    buildConfirmPassword(),
                                    SizedBox(height: 10),
                                    buildContinueBtn()
                                  ]
                              )
                          )
                      )
                    ]
                )
            )
        )
    );
  }
}


