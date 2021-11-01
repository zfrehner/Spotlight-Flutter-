import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import '../workout_classes/workout.dart';


class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  DateTime _currentDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: CalendarCarousel(
        onDayPressed: (DateTime date, List events) {
          this.setState(() => _currentDate = date);
          // Navigator.pushNamed(context, '/workout',
          //     arguments: 7);
          Navigator.pushNamed(context, Workout.id,arguments: _currentDate);
        },
        weekendTextStyle: TextStyle(
          color: Colors.red,
        ),
        thisMonthDayBorderColor: Colors.white,
        daysTextStyle: TextStyle(
            color: Colors.white
        ),
        headerTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),
        iconColor: Colors.white,
//      weekDays: null, /// for pass null when you do not want to render weekDays
//      headerText: Container( /// Example for rendering custom header
//        child: Text('Custom Header'),
//      ),
        customDayBuilder: (   /// you can provide your own build function to make custom day containers
            bool isSelectable,
            int index,
            bool isSelectedDay,
            bool isToday,
            bool isPrevMonthDay,
            TextStyle textStyle,
            bool isNextMonthDay,
            bool isThisMonthDay,
            DateTime day,
            ) {
          /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
          /// This way you can build custom containers for specific days only, leaving rest as default.
          // Example: every 15th of month, we have a flight, we can place an icon in the container like that:
          if (day.day == 15) {
            return Center(
              child: Icon(Icons.fitness_center),
            );
          } else {
            return null;
          }
        },
        weekFormat: false,
        //markedDatesMap: _markedDateMap,
        height: 420.0,
        selectedDateTime: _currentDate,
        selectedDayBorderColor: Colors.white,
        selectedDayButtonColor: Colors.white24,
        daysHaveCircularBorder: null, /// null for not rendering any border, true for circular border, false for rectangular border
      ),
    );
  }
}