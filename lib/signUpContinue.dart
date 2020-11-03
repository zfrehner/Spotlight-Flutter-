import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpContinue extends StatefulWidget {

  @override
  _SignUpContinueState createState() => _SignUpContinueState();
}

class _SignUpContinueState extends State<SignUpContinue> {

  Widget buildAddressField() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Address',
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
                        Icons.house,
                        color: Color(0xffFF3232)
                    ),
                    hintText: 'Address',
                    hintStyle: TextStyle(
                      color: Colors.black38,
                    )
                )
            ),
          )
        ]
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
                                              'Sign Up Cont.',
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
                                    buildAddressField()
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
