
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'workouts.dart';


class Workout extends StatefulWidget {
  static const String route = '/workout';
  static const String id = "workout";
  @override
  _WorkoutState createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  @override

  Map<String, bool> workouts = {
    'Biceps':false,
    'Shoulders':false,
    'Triceps':false,
    'Chest':false,
    'Back':false,
    'Legs':false,

  };

  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    var today = formatDate(DateTime.parse(args.toString().substring(0,10)),[MM,' - ',dd]);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Center(
          child: Text(
               today+' Workout',
              style: TextStyle(fontSize: 25.0,)
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              //_auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),

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