import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'loginPage.dart';

import 'package:spotlight_login/signUpPage.dart';
import 'package:spotlight_login/successPage.dart';
import 'package:spotlight_login/homePage.dart';
import 'userAlreadyBeenCreatedPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      /*home: LoginScreen(),*/
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id : (context) => LoginScreen(),
        SignUpScreen.id : (context) => SignUpScreen(),
        Success.id : (context) => Success(),
        AlreadyCreated.id : (context) => AlreadyCreated(),
        LandPage.id : (context) => LandPage()
      }
    );
  }
}
