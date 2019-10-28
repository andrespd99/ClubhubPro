import 'package:flutter/material.dart';

import 'Calendario.dart';
import 'Reservaciones.dart';
import 'colors.dart';
import 'invitaciones.dart';
import 'login.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  int _currentIndex = 0;

  Widget callPage(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return News();
      case 1:
        return Invitaciones();
      case 2:
        return Calendario();
      case 3:
        return Reservaciones();
        // case 4:
        //   return AdminPanel();

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
        backgroundColor: kClubhubBlue400,
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
          BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(Icons.calendar_today),
              title: Text('Calendario') //ICONO CALENDARIO
              ),
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
            title: Text('precio de invitaciones'),
            leading: Icon(Icons.info),
          ),
          ListTile(
            title: Text('Historial de Pagos'),
            leading: Icon(Icons.payment),
          ),
          ListTile(
            title: Text('Historial de visitas'),
            leading: Icon(Icons.visibility),
          ),
          ListTile(
            title: Text('Historial de invitados'),
            leading: Icon(Icons.person_pin),
          ),
          ListTile(
            title: Text('Configuracion de cuenta'),
            leading: Icon(Icons.new_releases),
          ),
          ListTile(
            title: Text('soporte al cliente'),
            leading: Icon(Icons.help),
          ),
          ListTile(
            title: Text('cerrar sesion'),
            leading: Icon(Icons.close),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
