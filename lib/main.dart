import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'loginPage.dart';

import 'package:spotlight_login/signUpPage.dart';
import 'package:spotlight_login/successPage.dart';
import 'package:spotlight_login/homePage.dart';
import 'userAlreadyBeenCreatedPage.dart';
import 'package:spotlight_login/gymViews/gymCardView.dart';
import 'package:spotlight_login/gymViews/gym1View.dart';
import 'package:spotlight_login/gymViews/gym2View.dart';
import 'package:spotlight_login/gymViews/gym3View.dart';
import 'package:spotlight_login/gymViews/gym4View.dart';
import 'package:spotlight_login/forgotPassword.dart';
import 'workout_classes/workout.dart';

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
        theme: ThemeData.dark().copyWith(
          backgroundColor: Colors.red,
          primaryColor: Colors.red,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.black87
          ),
          bottomNavigationBarTheme:  BottomNavigationBarThemeData(
            backgroundColor: Colors.red,
          ),
        ),
        title: 'Spotlight Login',
        debugShowCheckedModeBanner: false,
        /*home: LoginScreen(),*/
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id : (context) => LoginScreen(),
          SignUpScreen.id : (context) => SignUpScreen(),
          Success.id : (context) => Success(),
          AlreadyCreated.id : (context) => AlreadyCreated(),
          LandPage.id : (context) => LandPage(),
          GymCardView.id : (context) => GymCardView(),
          GymCardOneView.id : (context) => GymCardOneView(),
          GymCardTwoView.id : (context) => GymCardTwoView(),
          GymCardThreeView.id : (context) => GymCardThreeView(),
          GymCardFourView.id : (context) => GymCardFourView(),
          ForgotPassword.id : (context) => ForgotPassword(),
          Workout.id : (context) => Workout()
        }
    );
  }
}
