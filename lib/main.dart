import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'loginPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      title: 'Spotlight Login',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
