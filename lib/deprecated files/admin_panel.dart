import 'package:flutter/material.dart';


class AdminPanel extends StatefulWidget {
  AdminPanelState createState()=> AdminPanelState();
    Widget build(BuildContext context) {
      return Container(color: Colors.yellow,);
    }
    
  }
  
  
  class AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
     return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
       
        const SizedBox(height: 30),
        RaisedButton(
          onPressed: () {Navigator.pushNamed(context, '/listasociospage');},
          child: const Text(
            'Lista de Socios',
            style: TextStyle(fontSize: 20)
          ),
        ),
        const SizedBox(height: 30),
        RaisedButton(
          child: const Text(
            'Registrar Socio',
            style: TextStyle(fontSize: 20)
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/add-socio');
        
          }),
    ]),
        
    );
  }
  }
