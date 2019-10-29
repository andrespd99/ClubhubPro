import 'package:clubhub/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:clubhub/login.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newTextTheme = Theme.of(context).textTheme.apply(
          bodyColor: kClubhubTextPrimary,
          displayColor: kClubhubTextPrimary,
        );

    return MaterialApp(
      home: LoginPage(),
      theme: ThemeData(
        primaryColor: kClubhubBlueMain,
        primaryColorDark: kClubhubBlueDark,
        primaryColorLight: kClubhubBlueLight,
        textTheme: newTextTheme,
      ),
    );
  }
}
