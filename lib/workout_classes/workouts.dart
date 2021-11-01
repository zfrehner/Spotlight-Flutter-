import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Workouts extends StatefulWidget {
  static const String id = "workout";
  @override
  _WorkoutsState createState() => _WorkoutsState();
}

class _WorkoutsState extends State<Workouts> {
  Map<String, bool> workouts = {
    'Biceps':false,
    'Shoulders':false,
    'Triceps':false,
    'Chest':false,
    'Back':false,
    'Legs':false,

  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          ListTileTheme(
            textColor: Colors.black,
            tileColor: Colors.redAccent,

            child: ListView(
              children: workouts.keys.map((String key) {
                return new CheckboxListTile(
                  checkColor: Colors.black,
                  contentPadding: EdgeInsets.fromLTRB(30, 0, 250, 0),
                  title: new Text(key),
                  value: workouts[key],
                  onChanged: (bool value){
                    setState(() {
                      workouts[key] = value;
                    });
                  },
                );
              }).toList(),
            )
          )
    );
  }

}