import 'package:flutter/material.dart';

import 'hab_page.dart';

class Reservaciones extends StatefulWidget {
  ReservacionesState createState() => ReservacionesState();
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
    );
  }
}

class ReservacionesState extends State<Reservaciones> {
  @override
  Widget build(BuildContext context) {
    return ListasHabPage();
  }
}
