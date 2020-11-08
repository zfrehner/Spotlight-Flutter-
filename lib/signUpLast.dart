import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:spotlight_login/successPage.dart';

class SignUpLast extends StatefulWidget {
  @override
  _SignUpLastState createState() => _SignUpLastState();
}

class _SignUpLastState extends State<SignUpLast> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  List<ListItem> _dropdownItems = [
    ListItem(1, "Choose..."),
    ListItem(2, "Male"),
    ListItem(3, "Female"),
    ListItem(4, "Other")
  ];

  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;

  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

 Widget buildGenderChoice() {

    return Row(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Gender',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(top:5.0, left: 130.0),
            child: Container(
              padding: EdgeInsets.only(left: 15.0),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
                ),
          child: DropdownButtonHideUnderline(
              child: DropdownButton<ListItem>(
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
                  value: _selectedItem,
                  items: _dropdownMenuItems,
                  onChanged: (value) {
                    setState(() {
                      _selectedItem = value;

                    });
                  }),
            ),
          ),
          ),
        ]);
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
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,

          ),
// defaultSelectedCountryIsoCode: 'KE',
          cursorColor: Colors.white,
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
      'Birthday',
      style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold
      ),
    ),

     Padding(
       padding: const EdgeInsets.only(left: 8.0),
       child: Row(
         children: <Widget>[
           Text(_dateTime == null ? 'Please Select:' : _dateTime.toString(),
           style: TextStyle(
             color: Colors.white,
               fontSize: 16,
               fontWeight: FontWeight.bold,
           ),
          ),
         ],
       ),
     ),
     Padding(
       padding: EdgeInsets.only(left: 10.0),
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
          ),
         ),
         onPressed: () {
           showDatePicker(context: context,
               initialDate: DateTime.now(),
               firstDate: DateTime(1900),
               lastDate: DateTime.now()
           ).then((date) {
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

                        SizedBox(height: 30),
                        buildAgeField(),
                        SizedBox(height: 30),
                        buildGenderChoice(),
                        SizedBox(height: 30),
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
                              Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Success()));
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

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}


/*
Widget buildGenderChoice() {

  var isSelected = true;

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
              child: FilterChip(
                selectedColor: Colors.white,
                label: Text('Male'),
                labelStyle: TextStyle(
                    color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                selectedShadowColor: Colors.white,
                backgroundColor: Colors.white,
                selected: !isSelected,
                onSelected: (isSelected) {
                  setState(() {
                    isSelected = isSelected;

                  });
                },
                //selectedColor: Colors.red,
              ),
            ),
            FilterChip(
              label: Text('Female'),
              labelStyle: TextStyle(
                  color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
              selected: !isSelected,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              backgroundColor: Colors.white,
              selectedShadowColor: Colors.black,
              onSelected : (isSelected) {
                setState(() {
                  isSelected = isSelected;
                });
              },
              selectedColor: Colors.white,
            ),
          ]
      ),
      SizedBox(height: 10),

    ],
  );
}*/

