import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotlight_login/successPage.dart';
import 'package:intl/intl.dart';
import 'constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotlight_login/constants.dart';
import 'max_lengths_formatter.dart';
import '';

class SignUpScreen extends StatefulWidget {
  static const String id = 'signup_screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //creating an instance of a user -
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

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

      }
    } catch (e) {
      print(e);
    }
  }

  void showSnackBar (BuildContext context, String text) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(text),
      ),);
  }

  // **************** artems code: fields *****************************************
  // creating a global key for use for the form
  var _formKey = GlobalKey<FormState>();

  // fields to validate password/confirmPassword
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  // ***************************************************************************

  // variable to store selected gender
  String genderSelected = 'Choose..';

  // list for gender dropdown
  var genderOptions = ['Choose..', 'Male', 'Female'];

  //form field variables
  String firstName;
  String lastName;
  String country = "Canada";
  String address;
  String city;
  String state;
  String zipCode;
  String password;
  String email;
  String gender;
  int age;

  //variable for phone number
  var phoneNumber;
  DateTime dateTime;

  // *********************** Age calculator Function ***************************
  calculateAge (DateTime birthdate) {
    DateTime current = DateTime.now();
    age = current.year - birthdate.year;
    int month1 = current.month;
    int month2 = birthdate.month;
    if(month1 < month2) {
      age--;
    }
    if(month1 == month2) {
      int day1 = current.day;
      int day2 = birthdate.day;
      if(day1 < day2) {
        age--;
      }
    }
    return age;
  }

  //******************************* Show Dialogue Box ****************************
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Spotlight Notice!'),
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please choose your age.'),
                Text('You must be at least 16 years old.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Continue'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //***************************show gender dialog ****************************
  Future<void> _showGenderDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Spotlight Notice!'),
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please choose your gender.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Continue'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

//**************************** First Name Input Field **************************
  Widget buildFirstNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'First Name',
          style: kLoginTextStyle,
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kSignUpBoxDecoration,
          height: 60,
          child: Builder(
            builder: (context) => TextFormField(
              onChanged: (value) {
                firstName = value;
              },
              validator: (name) {
                // trim off whitespace
                name = name.trim();
                Pattern pattern = r'^[A-Za-z]+(?:[ _-][A-Za-z]+)*$';
                RegExp regex = new RegExp(pattern);
                if (name.isEmpty)
                  return '    Please enter a first name';
                else if (!regex.hasMatch(name))
                  return '    Invalid first name';
                else
                  return null;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.person,
                  color: Color(0xffFF3232),
                ),
                hintText: 'First Name',
                hintStyle: TextStyle(
                  color: Colors.black38,
                ),
                errorStyle: kErrorTextStyle,
              ),
              inputFormatters: [
                MaxLengthFormatter(20, (){
                  showSnackBar(context, 'Only 20 characters allowed for First Name.');
                },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

//**************************** Last Name Input Field ***************************
  Widget buildLastNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Last Name',
          style: kLoginTextStyle,
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kSignUpBoxDecoration,
          height: 60,
          child: Builder(
            builder: (context) => TextFormField(
              onChanged: (value) {
                lastName = value;
              },
              validator: (name) {
                // trim off whitespace
                name = name.trim();
                Pattern pattern = r'^[A-Za-z]+(?:[ _-][A-Za-z]+)*$';
                RegExp regex = new RegExp(pattern);
                if (name.isEmpty)
                  return '    Please enter a last name';
                else if (!regex.hasMatch(name))
                  return '    Invalid last name';
                else
                  return null;
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(Icons.person, color: Color(0xffFF3232)),
                  hintText: 'Last Name',
                  hintStyle: TextStyle(
                    color: Colors.black38,
                  ),
                  errorStyle: kErrorTextStyle
              ),
              inputFormatters: [
                MaxLengthFormatter(20, (){
                  showSnackBar(context, 'Only 20 characters are allowed for Last Name.');
                },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

//**************************** Email Input Field *******************************
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
          decoration: kSignUpBoxDecoration,
          height: 60,
          child: Builder(
            builder: (context) => TextFormField(
              onChanged: (value) {
                email = value.trim();
              },
              keyboardType: TextInputType.emailAddress,
              validator: (email) {
                Pattern pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regex = new RegExp(pattern);
                if (email.trim().isEmpty)
                  return '    Please enter an email';
                else if (!regex.hasMatch(email.trim()))
                  return '    Invalid email';
                else
                  return null;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.email, color: Color(0xffFF3232)),
                hintText: 'Email',
                hintStyle: TextStyle(
                  color: Colors.black38,
                ),
                errorStyle: kErrorTextStyle,
              ),
              inputFormatters: [
                MaxLengthFormatter(25, (){
                  showSnackBar(context, 'Only 25 characters are allowed for Email.');
                },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

//**************************** Country Input Field *****************************
  Widget buildCountryPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Choose Country',
          style: kLoginTextStyle,
        ),
        SizedBox(height: 10),
        FormBuilderCountryPicker(
          onChanged: (value) {
            country = value.name;
          },
          attribute: 'country_picker',
          initialValue: 'Canada',
        ),
      ],
    );
  }

//**************************** Address Input Field *****************************
  Widget buildAddressField() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Address (for promotions/coupons)',
            style: kLoginTextStyle,
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kSignUpBoxDecoration,
            height: 60,
            child: Builder(
              builder: (context) => TextFormField(
                onChanged: (value) {
                  address = value;
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(Icons.house, color: Color(0xffFF3232)),
                  errorStyle: kErrorTextStyle,
                  hintText: 'Address',
                  hintStyle: TextStyle(
                    color: Colors.black38,
                  ),
                ),
                inputFormatters: [
                  MaxLengthFormatter(20, (){
                    showSnackBar(context, 'Only 20 characters are allowed for Address.');
                  },
                  ),
                ],
              ),
            ),
          ),
        ]);
  }

//**************************** City Input Field ********************************
  Widget buildCityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'City',
          style: kLoginTextStyle,
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kSignUpBoxDecoration,
          height: 60,
          child: Builder(
            builder: (context) => TextFormField(
              onChanged: (value) {
                city = value;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.location_city, color: Color(0xffFF3232)),
                hintText: 'City',
                errorStyle: kErrorTextStyle,
                hintStyle: TextStyle(
                  color: Colors.black38,
                ),
              ),
              inputFormatters: [
                MaxLengthFormatter(20, (){
                  showSnackBar(context, 'Only 20 characters are allowed for a City.');
                },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

//**************************** State Input Field *******************************
  Widget buildStateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'State/Province',
          style: kLoginTextStyle,
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kSignUpBoxDecoration,
          height: 60,
          child: Builder(
            builder: (context) => TextFormField(
              onChanged: (value) {
                state = value;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.landscape_sharp, color: Color(0xffFF3232)),
                hintText: 'State or Province',
                errorStyle: kErrorTextStyle,
                hintStyle: TextStyle(
                  color: Colors.black38,
                ),
              ),
              inputFormatters: [
                MaxLengthFormatter(20, (){
                  showSnackBar(context, 'Only 20 characters are allowed.');
                },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

//**************************** Zip Input Field *********************************
  Widget buildZipField() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Zip Code',
            style: kLoginTextStyle,
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kSignUpBoxDecoration,
            height: 60,
            child: TextFormField(
              onChanged: (value) {
                zipCode = value;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon:
                Icon(Icons.location_on_sharp, color: Color(0xffFF3232)),
                errorStyle: kErrorTextStyle,
                hintText: 'Zip Code',
                hintStyle: TextStyle(
                  color: Colors.black38,
                ),
              ),
              inputFormatters: [
                MaxLengthFormatter(10, (){
                  showSnackBar(context, 'Only 10 characters are allowed for the Zip Code.');
                },
                ),
              ],
            ),
          ),
        ]);
  }

//**************************** First Name Input Field **************************
  Widget buildAgeField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: [
            Text(
              'Birthday:',
              style: kLoginTextStyle,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Age: ',
              style: kLoginTextStyle,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: <Widget>[
              Column(
                children: [
                  Text(
                    dateTime == null
                        ? 'Please Select:'
                        : DateFormat('MMMM-dd-yyyy').format(dateTime),
                    style: kLoginTextStyle,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    age == null
                        ? ' '
                        : age.toString(),
                    style: kLoginTextStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: RaisedButton(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            color: Colors.white,
            child: Text(
              'Pick a date',
              style: TextStyle(
                  color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              showDatePicker(
                  context: context,
                  initialDate: dateTime == null ? DateTime.now().subtract(Duration(days: 5844)) : dateTime,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now().subtract(Duration(days: 5844)))
                  .then((date) {
                setState(() {
                  dateTime = date;
                  age = calculateAge(date);
                },
                );
              },
              );
            },
          ),
        ),
      ],
    );
  }

//**************************** Gender Input Field ******************************
  Widget buildGenderChoice() {
    return Row(
      children: <Widget>[
        Text(
          'Gender',
          style: kLoginTextStyle,
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(top: 5.0, left: 130.0),
          child: Container(
            padding: EdgeInsets.only(left: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  value: genderSelected,
                  items: genderOptions.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      genderSelected = value;
                      gender = value;
                      print(value);
                    });
                  }),
            ),
          ),
        ),
      ],
    );
  }

//**************************** Phone Number Input Field ************************
  Widget buildPhoneNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Phone (To receive text updates)',
          style: kLoginTextStyle,
        ),
        SizedBox(height: 10),
        Builder(
          builder: (context) => FormBuilderPhoneField(
            attribute: 'phone_number',
            initialValue: ' ',
            style: kLoginTextStyle,
            cursorColor: Colors.white,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Phone Number',
            ),
            onChanged: (value) {
              phoneNumber = value;
            },
            priorityListByIsoCode: ['US'],
            validators: [
              FormBuilderValidators.required(errorText: 'This field required')
            ],
            inputFormatters: [
              MaxLengthFormatter(16, (){
                showSnackBar(context, 'Only 16 characters are allowed for Phone Number.');
              },
              ),
            ],
          ),
        ),
      ],
    );
  }

//**************************** Password Input Field ****************************
  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLoginTextStyle,
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kSignUpBoxDecoration,
          height: 60,
          child: Builder (
            builder: (context) => TextFormField(
              onChanged: (value) {
                password = value;
              },
              controller: _password,
              obscureText: true,
              validator: (password) {
                if (password.isEmpty)
                  return '    Please enter a password';
                else if (password.length < 8)
                  return '    Password too short';
                else
                  return null;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.lock, color: Color(0xffFF3232)),
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: Colors.black38,
                ),
                errorStyle: kErrorTextStyle,
              ),
              inputFormatters: [
                MaxLengthFormatter(25, (){
                  showSnackBar(context, 'Only 25 characters are allowed for a Password.');
                },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
//************************ Confirm Password Input Field ************************
  Widget buildConfirmPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Confirm Password',
          style: kLoginTextStyle,
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kSignUpBoxDecoration,
          height: 60,
          child: Builder (
            builder: (context) => TextFormField(
              // ******** artems code: add controller *********************
              controller: _confirmPassword,
              // ***********************************************************
              obscureText: true,
              // ************ Artems code: validator *************************
              validator: (password) {
                if (password.isEmpty)
                  return '    Please re-enter password';
                else if (_password.text != _confirmPassword.text)
                  return '    Passwords must match';
                else
                  return null;
              },
              // ***********************************************************
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.lock_open, color: Color(0xffFF3232)),
                hintText: 'Confirm Password',
                hintStyle: TextStyle(
                  color: Colors.black38,
                ),
                // ************* artems code: errorStyle *******************
                errorStyle: kErrorTextStyle,
                // *********************************************************
              ),
              inputFormatters: [
                MaxLengthFormatter(25, (){
                  showSnackBar(context, 'Only 25 characters are allowed for a Password.');
                },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

//****************************** Continue Field ********************************
  Widget buildContBtn() {
    return GestureDetector(
      onTap: ()  {
        setState(() async {

          if (_formKey.currentState.validate()) {
            //registering the user with the form fields
            //returns a "Future"
            //capture the new user
            //async and await mean the user is authenticated before we go on
            try {

              if(dateTime == null || gender == "Choose.." || genderSelected == "Choose..") {
                if(gender == "Choose.." || genderSelected == "Choose..") {
                  _showGenderDialog();
                }
                if(dateTime == null) {
                  _showMyDialog();
                }
              } else {
                await _auth
                    .createUserWithEmailAndPassword(
                    email: email, password: password)
                    .then(
                      (loggedInUser) =>
                      _firestore
                          .collection('SpotlightUsers')
                          .doc(_auth.currentUser.uid)
                          .set(
                        {
                          'uid': _auth.currentUser.uid,
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
                          'hobbies': null,
                          'workout': null,
                          'imageString' : null
                        },
                      ),
                );

                if (_auth.currentUser.uid != null) {
                  Navigator.pushNamed(context, Success.id);
                }
              }

            } catch (e) {
              print(e);
            }
          }
        },
        );
      },
      // *********************************************************************
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: 'Continue',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ))
        ],
        ),
      ),
    );
  }

//****************************** MAIN SCAFFOLD *********************************
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            child: Stack(children: <Widget>[
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
                        ])),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding:
                  EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: Text('Sign Up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          Hero(
                            tag: 'logo',
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(
                                  'assets/images/LOGO 4.jpg'),
                            ),
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
                      buildCountryPicker(),
                      SizedBox(height: 10),
                      buildAddressField(),
                      SizedBox(height: 10),
                      buildCityField(),
                      SizedBox(height: 10),
                      buildStateField(),
                      SizedBox(height: 10),
                      buildZipField(),
                      SizedBox(height: 30),
                      buildAgeField(),
                      SizedBox(height: 30),
                      buildGenderChoice(),
                      SizedBox(height: 30),
                      buildPhoneNumber(),
                      SizedBox(height: 10),
                      buildPassword(),
                      SizedBox(height: 10),
                      buildConfirmPassword(),
                      SizedBox(height: 10),
                      buildContBtn()
                    ],
                  ),
                ),
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }
}