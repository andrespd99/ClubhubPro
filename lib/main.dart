import 'package:clubhub/colors.dart';
import 'package:flutter/material.dart';
import 'package:clubhub/Calendario.dart';
import 'package:clubhub/add_socio.dart';
import 'package:clubhub/admin_panel.dart';
import 'package:clubhub/invitaciones.dart';
import 'package:clubhub/listasocios_page.dart';
import 'package:clubhub/principal.dart';
import 'package:clubhub/login.dart';
import 'package:clubhub/Reservaciones.dart';
import 'Reservaciones.dart';
//import 'package:pruebais/routes.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: LoginPage(),
    theme: ThemeData(
      fontFamily: 'Roboto'
    ),

  );
  }
  
}

