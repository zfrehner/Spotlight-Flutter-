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

class SignUpScreen extends StatefulWidget {
  static const String id = 'signup_screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //creating an instance of a user -
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  //var firebaseUser = FirebaseAuth.instance.currentUser;

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

        //print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // **************** artems code: fields *****************************************
  // creating a global key for use for the form
  var _formKey = GlobalKey<FormState>();

  // fields to validate password/confirmPassword
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  // ***************************************************************************
  // List<ListItem> _dropdownItems = [
  //   ListItem(1, "Choose..."),
  //   ListItem(2, "Male"),
  //   ListItem(3, "Female")
  // ];

  // variable to store selected gender
  String genderSelected = 'Choose..';

  // list for gender dropdown
  var genderOptions = ['Choose..', 'Male', 'Female'];

  // List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  // //list item for selected gender
  // ListItem _gender;

  //form field variables
  String firstName;
  String lastName;
  String country;
  String address;
  String city;
  String state;
  String zipCode;
  String password;
  String email;
  String gender;

  //variable for phone number
  var phoneNumber;
  DateTime dateTime;

  // void initState() {
  //   super.initState();
  //   // _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
  //   _gender = _dropdownMenuItems[0].value;
  // }

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
          child: TextFormField(
            onChanged: (value) {
              firstName = value;
            },
            /*keyboardType: TextInputType.emailAddress,*/
            // ************ Artems code: validator ***************************
            validator: (name) {
              // trim off whitespace
              name = name.trim();
              Pattern pattern = r'^[A-Za-z]+(?:[ _-][A-Za-z]+)*$';
              RegExp regex = new RegExp(pattern);
              if (name.isEmpty)
                return 'Please enter a first name';
              else if (!regex.hasMatch(name))
                return 'Invalid first name';
              else
                return null;
            },
            // ***************************************************************
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Icons.person, color: Color(0xffFF3232)),
              hintText: 'First Name',
              hintStyle: TextStyle(
                color: Colors.black38,
              ),
              // ************* artems code: errorStyle *********************
              errorStyle: kErrorTextStyle,
            ),
          ),
          // *******************************************************************
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
          child: TextFormField(
            onChanged: (value) {
              lastName = value;
            },
            /*keyboardType: TextInputType.emailAddress,*/
            // ************ Artems code: validator *************************
            validator: (name) {
              // trim off whitespace
              name = name.trim();
              Pattern pattern = r'^[A-Za-z]+(?:[ _-][A-Za-z]+)*$';
              RegExp regex = new RegExp(pattern);
              if (name.isEmpty)
                return 'Please enter a last name';
              else if (!regex.hasMatch(name))
                return 'Invalid last name';
              else
                return null;
            },
            // *************************************************************
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.person, color: Color(0xffFF3232)),
                hintText: 'Last Name',
                hintStyle: TextStyle(
                  color: Colors.black38,
                ),
                // ************* artems code: errorStyle ***************************
                errorStyle: kErrorTextStyle),
          ),
          // *****************************************************************
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
          child: TextFormField(
            onChanged: (value) {
              email = value.trim();
            },
            keyboardType: TextInputType.emailAddress,
            // ************ Artems code: validator *************************
            validator: (email) {
              Pattern pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regex = new RegExp(pattern);
              if (email.trim().isEmpty)
                return 'Please enter an email';
              else if (!regex.hasMatch(email.trim()))
                return 'Invalid email';
              else
                return null;
            },
            // *************************************************************
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Icons.email, color: Color(0xffFF3232)),
              hintText: 'Email',
              hintStyle: TextStyle(
                color: Colors.black38,
              ),
              // ************* artems code: errorStyle *********************
              errorStyle: kErrorTextStyle,
              // ***********************************************************
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
            country = value.toString();
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
            child: TextFormField(
              onChanged: (value) {
                address = value;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.house, color: Color(0xffFF3232)),
                // ************* artems code: errorStyle *******************
                errorStyle: kErrorTextStyle,
                // *********************************************************
                hintText: 'Address',
                hintStyle: TextStyle(
                  color: Colors.black38,
                ),
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
          child: TextFormField(
            onChanged: (value) {
              city = value;
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Icons.location_city, color: Color(0xffFF3232)),
              hintText: 'City',
              // ************* artems code: errorStyle *******************
              errorStyle: kErrorTextStyle,
              // *********************************************************
              hintStyle: TextStyle(
                color: Colors.black38,
              ),
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
          child: TextFormField(
            onChanged: (value) {
              state = value;
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Icons.landscape_sharp, color: Color(0xffFF3232)),
              hintText: 'State or Province',
              // ************* artems code: errorStyle *******************
              errorStyle: kErrorTextStyle,
              // *********************************************************
              hintStyle: TextStyle(
                color: Colors.black38,
              ),
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
                // ************* artems code: errorStyle *******************
                errorStyle: kErrorTextStyle,
                // *********************************************************
                hintText: 'Zip Code',
                hintStyle: TextStyle(
                  color: Colors.black38,
                ),
              ),
            ),
          ),
        ]);
  }

//**************************** First Name Input Field **************************
  Widget buildAgeField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Birthday',
          style: kLoginTextStyle,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: <Widget>[
              Text(
                dateTime == null
                    ? 'Please Select:'
                    : DateFormat('MMMM-dd-yyyy').format(dateTime),
                style: kLoginTextStyle,
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
                      initialDate: dateTime == null ? DateTime.now() : dateTime,
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now())
                  .then((date) {
                setState(() {
                  dateTime = date;
                });
              });
            },
          ),
        ),
      ],
    );
  }

//**************************** Gender Input Field ******************************
  Widget buildGenderChoice() {
    return Row(
        //crossAxisAlignment: CrossAxisAlignment.start,
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
        ]);
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
        //SizedBox(height: 15),
        FormBuilderPhoneField(
          attribute: 'phone_number',
          initialValue: ' ',
          style: kLoginTextStyle,
// defaultSelectedCountryIsoCode: 'KE',
          cursorColor: Colors.white,
// style: TextStyle(color: Colors.black, fontSize: 18),
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
            child: TextFormField(
              onChanged: (value) {
                password = value;
              },
              // ******** artems code: add contorller *********************
              controller: _password,
              // ***********************************************************
              obscureText: true,
              // ************ Artems code: validator ***********************
              validator: (password) {
                if (password.isEmpty)
                  return 'Please enter a password';
                else if (password.length < 8)
                  return 'Password too short';
                else
                  return null;
              },
              // ***********************************************************
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.lock, color: Color(0xffFF3232)),
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: Colors.black38,
                ),
                // ************* artems code: errorStyle *******************
                errorStyle: kErrorTextStyle,
                // *********************************************************
              ),
            ),
          ),
        ]);
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
              child: TextFormField(
                  // ******** artems code: add contorller *********************
                  controller: _confirmPassword,
                  // ***********************************************************
                  obscureText: true,
                  // ************ Artems code: validator *************************
                  validator: (password) {
                    if (password.isEmpty)
                      return 'Please re-enter password';
                    else if (_password.text != _confirmPassword.text)
                      return 'Passwords must match';
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
                  )))
        ]);
  }

//****************************** Continue Field ********************************
  Widget buildContBtn() {
    return GestureDetector(
        // ***************** Artems code *****************************************
        // onTap: () => Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => SignUpContinue()),
        //     ),
        onTap: () async {
          print(firstName);
          print(lastName);
          print(email);
          print(country); //getting null
          print(address);
          print(city);
          print(state);
          print(zipCode);
          print(dateTime);
          print(gender); //getting instance of ListItem
          print(phoneNumber); //getting null
          print(password);

          setState(() {
            if (_formKey.currentState.validate()) {
              //registering the user with the form fields
              //returns a "Future"
              //capture the new user
              //async and await mean the user is authenticated before we go on
              try {
                  _auth
                    .createUserWithEmailAndPassword(
                        email: email, password: password)
                    .then(
                      (loggedInUser) => _firestore
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
                          'phoneNumber': phoneNumber
                        },
                      ),
                    );
              } catch (e) {
                print(e);
              }
              if (_auth.currentUser.uid != null) {
                Navigator.pushNamed(context, Success.id);
              }

              // if validate = true, take user to next page
              //Navigator.pushNamed(context, Success.id);
            }
          });
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
        ])));
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
                            ])))
              ])))),
    );
  }
}

//****************************** Drop Down Menu ********************************
// List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
//   List<DropdownMenuItem<ListItem>> items = List();
//   for (ListItem listItem in listItems) {
//     items.add(
//       DropdownMenuItem(
//         child: Text(listItem.name),
//         value: listItem,
//       ),
//     );
//   }
//   return items;
// }

//****************************** List Item Class *******************************
// class ListItem {
//   ListItem(this.value, this.name);
//   int value;
//   String name;
// }
