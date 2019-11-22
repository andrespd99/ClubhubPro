import 'package:clubhub/hab_page.dart';
import 'package:clubhub/historial_Reservaciones.dart';
import 'package:clubhub/login.dart';
import 'package:clubhub/models/invitations/InvitationHistory.dart';
import 'package:clubhub/models/news/Bookmarks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:clubhub/models/news/News.dart';
import 'package:clubhub/assets/colors.dart';

import 'models/invitations/invitationMain.dart';

class Home extends StatefulWidget {
  //Home({Key key}) : super(key: key);
   final FirebaseUser currentUser;    

  Home(this.currentUser);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  Widget callPage(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return News();
      case 1:
        return InvitationMain();
      case 2:
        return ListasHabPage();

        break;
      default:
        return News();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: invokeDrawer(),
      appBar: AppBar(
        title: Text(''),
        backgroundColor: kClubhubBlue400,
      ),
      body: callPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: kClubhubBlueMain,
        currentIndex: _currentIndex,
        onTap: (value) {
          _currentIndex = value;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(Icons.home), //ICONO DE HOME
              title: Text('Principal')),
          BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(Icons.person_add),
              title: Text('Invitaciones') // ICONO INVITACIONES
              ),
          // BottomNavigationBarItem(
          //     backgroundColor: Colors.blue,
          //     icon: Icon(Icons.calendar_today),
          //     title: Text('Calendario') //ICONO CALENDARIO
          //     ),
          BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(Icons.hotel),
              title: Text('Reservaciones') //ICONO RESERVACIONES
              )
          // BottomNavigationBarItem(
          //     backgroundColor: Colors.blue,
          //     icon: Icon(Icons.insert_emoticon),
          //     title: Text('Administrar') //ICONO RESERVACIONES
          //     )
        ],
      ),
    );
  }

  Widget invokeDrawer() {
    return Drawer(
      child: new ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Valeska De Ponte"),
            accountEmail: Text("Valeskadeponte@prueba.es"),
            currentAccountPicture: CircleAvatar(backgroundColor: Colors.white),
            decoration: BoxDecoration(
              color: Colors.lightBlue,
            ),
          ),
          ListTile(
            title: Text('Noticias guardadas'),
            leading: Icon(Icons.bookmark),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Bookmarks()));}
          ),
          ListTile(
            title: Text('Historial'),
            leading: Icon(Icons.history),
            onTap: () {
              Navigator.push( 
            context,
            MaterialPageRoute(
                            builder: (context) =>
                                HistorialReservaciones(),
                          ),
                        );
            },
          ),
          // ListTile(
          //   title: Text('Historial de invitaciones'),
          //   leading: Icon(Icons.payment),
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => InvitationHistory()));
          //   },
          // ),
          // ListTile(
          //   title: Text('Historial de visitas'),
          //   leading: Icon(Icons.visibility),
          // ),
          // ListTile(
          //   title: Text('Historial de invitados'),
          //   leading: Icon(Icons.person_pin),
          // ),
          // ListTile(
          //   title: Text('Configuracion de cuenta'),
          //   leading: Icon(Icons.new_releases),
          // ),
          // ListTile(
          //   title: Text('soporte al cliente'),
          //   leading: Icon(Icons.help),
          // ),
          // ListTile(
          //   title: Text('cerrar sesion'),
          //   leading: Icon(Icons.close),
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => LoginPage()));
          //   },
          // ),
        ],
      ),
    );
  }
}
