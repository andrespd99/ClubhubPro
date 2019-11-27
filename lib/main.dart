import 'package:clubhub/Home.dart';
import 'package:clubhub/assets/colors.dart';
import 'package:clubhub/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('lib/assets/images/invitations.jpeg'), context);
    precacheImage(
        AssetImage('lib/assets/images/invitation_history.jpg'), context);
    precacheImage(AssetImage('lib/assets/images/loading.gif'), context);
    final clubhubTextTheme = Theme.of(context).textTheme.apply(
          bodyColor: kClubhubTextPrimary,
          displayColor: kClubhubTextPrimary,

          
        );

    final appBarTextTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Colors.white, bodyColor: Colors.white);

    final clubhubButtonTheme = Theme.of(context).buttonTheme.copyWith(
        disabledColor: kClubhubTextPrimary,
        buttonColor: kClubhubBlueMain,
        textTheme: ButtonTextTheme.primary);

    return MaterialApp(
      initialRoute: '/',
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
        textTheme: clubhubTextTheme,
        buttonTheme: clubhubButtonTheme,
      ),
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => Home(),
      },
    );
  }
}
