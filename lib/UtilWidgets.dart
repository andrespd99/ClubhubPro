import 'package:clubhub/assets/colors.dart';
import 'package:flutter/material.dart';

Widget showLoadingCircle() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text("Cargando...",
            style: TextStyle(
              color: kClubhubBlueDark,
            ))
      ],
    ),
  );
}