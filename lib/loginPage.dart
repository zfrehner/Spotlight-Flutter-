import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotlight_login/signUpPage.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen> {

  bool isChecked = false;

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
        onPressed: () => print('Login was pressed'),
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
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUpScreen()),
      ),
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
      )
    );
  }
}

