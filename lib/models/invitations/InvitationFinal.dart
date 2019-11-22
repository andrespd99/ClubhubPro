import 'package:clubhub/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InvitationFinal extends StatefulWidget {
  InvitationFinal({Key key}) : super(key: key);

  @override
  _InvitationFinalState createState() => _InvitationFinalState();
}

class _InvitationFinalState extends State<InvitationFinal> {
  get currentUser => null;

  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Invitacion registrada.'),
          Center(
            child: RaisedButton(
              child: Text('Regresar'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Home(this.currentUser)),
                        (Route<dynamic> route) => false,
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
