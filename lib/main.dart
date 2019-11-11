import 'package:clubhub/Home.dart';
import 'package:clubhub/assets/colors.dart';
import 'package:clubhub/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newTextTheme = Theme.of(context).textTheme.apply(
          bodyColor: kClubhubTextPrimary,
          displayColor: kClubhubTextPrimary,
        );

    final appBarTextTheme = Theme.of(context).textTheme.apply(
          displayColor: Colors.white,
          bodyColor: Colors.white
        );



    return MaterialApp(
      home: LoginPage(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          textTheme: appBarTextTheme,
          color: kClubhubBlueMain,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        fontFamily: 'Poppins-Medium',
        primaryColor: kClubhubBlueMain,
        primaryColorDark: kClubhubBlueDark,
        primaryColorLight: kClubhubBlueLight,
        textTheme: newTextTheme,
        buttonTheme: ButtonThemeData(
          buttonColor: kClubhubBlueMain,
          textTheme: ButtonTextTheme.normal
        ),
      ),
    );
  }
}
