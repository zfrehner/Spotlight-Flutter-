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
      theme: ThemeData.dark(),
      title: 'Spotlight Login',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}