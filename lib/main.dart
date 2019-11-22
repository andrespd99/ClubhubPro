import 'package:clubhub/Home.dart';
import 'package:clubhub/assets/colors.dart';
import 'package:clubhub/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth.dart';
//import 'package:logincloud/loginemail.dart';

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
           home:LoginPage(),
    );
}
}
           /* FutureBuilder<FirebaseUser>(
        future: Provider.of<AuthService>(context).getUser(),
        builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // log error to console 
            if (snapshot.error != null) { 
              print("error");
              return Text(snapshot.error.toString());
            }
            // redirect to the proper page
            return snapshot.hasData ? Home(snapshot.data) : LoginPage();
          } else {
            // show loading indicator
            return LoadingCircle();
          }
        },
      ),
    );
  }
}
            
 class LoadingCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CircularProgressIndicator(),
        alignment: Alignment(0.0, 0.0),
      ),
    );
  }
}*/