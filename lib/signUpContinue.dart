//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:spotlight_login/signUpLast.dart';

class SignUpContinue extends StatefulWidget {

  @override
  _SignUpContinueState createState() => _SignUpContinueState();
}

class _SignUpContinueState extends State<SignUpContinue> {

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

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
                      offset: Offset(0, 2)
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

  Widget buildCountryPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Choose Country',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        FormBuilderCountryPicker(
          attribute: 'country_picker',
          initialValue: 'Canada',
        )
      ],
    );
  }

  Widget buildCityField() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'City',
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
                      offset: Offset(0, 2)
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
                        Icons.location_city,
                        color: Color(0xffFF3232)
                    ),
                    hintText: 'City',
                    hintStyle: TextStyle(
                      color: Colors.black38,
                    )
                )
            ),
          )
        ]
    );
  }

  Widget buildStateField() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'State/Province',
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
                      offset: Offset(0, 2)
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
                        Icons.landscape_sharp,
                        color: Color(0xffFF3232)
                    ),
                    hintText: 'State or Province',
                    hintStyle: TextStyle(
                      color: Colors.black38,
                    )
                )
            ),
          )
        ]
    );
  }

  Widget buildZipField() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Zip Code',
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
                      offset: Offset(0, 2)
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
                        Icons.location_on_sharp,
                        color: Color(0xffFF3232)
                    ),
                    hintText: 'Zip Code',
                    hintStyle: TextStyle(
                      color: Colors.black38,
                    )
                )
            ),
          )
        ]
    );
  }

  Widget buildContinueBtn() {
    return GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUpLast()),
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
          body: FormBuilder(
            key: _fbKey,
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
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
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
                                        buildCountryPicker(),
                                        SizedBox(height: 10),
                                        buildAddressField(),
                                        SizedBox(height: 10),
                                        buildCityField(),
                                        SizedBox(height: 10),
                                        buildStateField(),
                                        SizedBox(height: 10),
                                        buildZipField(),
                                        SizedBox(height: 10),
                                        buildContinueBtn(),
                                        //buildGenderChoice(),


                                        //buildTextArea()
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




//code for trying to "GET" from DB
 /* Widget buildTextArea() {
    return FutureBuilder(
      // Initialize FlutterFire
        future: getData(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          var doc = snapshot.data;
          if(doc.exists) {
            return Text(
              doc['content']
            );
          }
        }
        return Center(child: CircularProgressIndicator());
      }
    );
  }*/

/*Future<DocumentSnapshot> getData() async {
  await Firebase.initializeApp();
  return await FirebaseFirestore.instance
      .collection("Spotlight Users")
      .doc("Login Info")
      .get();
}*/






//code for phone number
/*SizedBox(height: 15),
FormBuilderPhoneField(
attribute: 'phone_number',
initialValue: '+25443534543567',
// defaultSelectedCountryIsoCode: 'KE',
cursorColor: Colors.black,
// style: TextStyle(color: Colors.black, fontSize: 18),
decoration: const InputDecoration(
border: OutlineInputBorder(),
labelText: 'Phone Number',
),
onChanged: _onChanged,
priorityListByIsoCode: ['US'],
validators: [
FormBuilderValidators.required(
errorText: 'This field required')
],*/

/*

spacing: 4,
alignment: WrapAlignment.spaceEvenly,
attribute: "gender_choice_chip",
decoration: InputDecoration(
labelStyle: TextStyle(
color: Colors.white)*/
