import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SignUpLast extends StatefulWidget {
  @override
  _SignUpLastState createState() => _SignUpLastState();
}

class _SignUpLastState extends State<SignUpLast> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  Widget buildGenderChoice() {

    var _isSelected = false;

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Gender',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
             Padding(
               padding: const EdgeInsets.only(right: 8.0),
               child: ChoiceChip(
                label: Text('Male'),
                labelStyle: TextStyle(
                    color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                backgroundColor: Colors.white,
                 selected: _isSelected,
                onSelected: (isSelected) {
                  setState(() {
                    _isSelected = isSelected;
                  });
                },
                selectedColor: Colors.red,
            ),
             ),
            ChoiceChip(
              label: Text('Female'),
              labelStyle: TextStyle(
                  color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
              selected: _isSelected,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              backgroundColor: Colors.white,
              onSelected: (isSelected) {
                setState(() {
                  _isSelected = !isSelected;
                });
              },
              selectedColor: Colors.red,
            ),
          ]
        ),
          SizedBox(height: 10),

      ],
    );
  }

  Widget buildPhoneField() {
    var _onChanged;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Phone',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        //SizedBox(height: 15),
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
            FormBuilderValidators.required(errorText: 'This field required')
          ],
        ),
      ],
    );
  }

  Widget buildAgeField() {
    DateTime _dateTime;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      Text(
      'Age',
      style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold
      ),
    ),
    SizedBox(height: 10),
     Row(
       children: [
         Text(_dateTime == null ? "" : _dateTime.toString(),
         style: TextStyle(
           color: Colors.white,
             fontSize: 16,
             fontWeight: FontWeight.bold
         )),
       ],
     ),
     Padding(
       padding: const EdgeInsets.only(top: 20.0),
       child: RaisedButton(
         shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(15)
         ),
         color: Colors.white,
         child: Text('Pick a date',
         style: TextStyle(
           color: Colors.red,
           fontSize: 16,
           fontWeight: FontWeight.bold
         )),
         onPressed: () {
           showDatePicker(context: context, initialDate: DateTime.now(),
               firstDate: DateTime(1900),
               lastDate: DateTime.now()).then((date) {
                   setState(() {
                       _dateTime = date;
             });
           });
         },
       ),
     )]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FormBuilder(
      key: _fbKey,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
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
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 40),
                              child: Text('Almost there...',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage('assets/images/LOGO 4.jpg'),
                            ),
                          ],
                        ),

                        SizedBox(height: 10),
                        buildAgeField(),
                        SizedBox(height: 10),
                        buildGenderChoice(),
                        SizedBox(height: 10),
                        buildPhoneField(),

                    Container(
                      padding: EdgeInsets.symmetric(vertical: 25),
                      width: double.infinity,
                       child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                          ),
                          color: Colors.white,
                          child: Text('Submit',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          onPressed: () {
                            if (_fbKey.currentState.saveAndValidate()) {
                              print(_fbKey.currentState.value);
                            }
                          },
                        ),

                        //buildGenderChoice(),

                        //buildTextArea()
                    )],
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
