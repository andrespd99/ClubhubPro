import 'package:clubhub/Home.dart';
import 'package:clubhub/assets/colors.dart';
import 'package:clubhub/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth.dart';

void main() => runApp(
      ChangeNotifierProvider<AuthService>(
        child: MyApp(),
        builder: (BuildContext context) {
          return AuthService();
        },
      ),
    );

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
            home: FutureBuilder(
        // get the Provider, and call the getUser method
        future: Provider.of<AuthService>(context).getUser(),
        // wait for the future to resolve and render the appropriate
        // widget for HomePage or LoginPage
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.hasData ? Home() : LoginPage();
          } else {
            return Container(color: Colors.white);
          }
        },
      ),
      /*routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => Home(),
      },*/
    );
  }
}
