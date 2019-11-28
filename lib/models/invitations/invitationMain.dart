import 'dart:ui';
import 'package:clubhub/models/invitations/InvitationHistory.dart';
//import 'package:clubhub/models/invitations/InvitationsNEW.dart';
import 'package:clubhub/models/invitations/Invitations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvitationMain extends StatefulWidget {
  @override
  _InvitationMainState createState() => _InvitationMainState();
}

class _InvitationMainState extends State<InvitationMain> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);


    return Column(
      children: <Widget>[
        //Contenedor registrar invitados
        Expanded(
          child: Container(
            width: double.infinity,
            child: InkWell(
              child: Stack(
                children: <Widget>[
                  backgroundImage(1),
                  onTopContent(1),
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Invitations()));
              },
            ),
          ),
        ),
        //Contenedor Historial de invitados
        Expanded(
          child: InkWell(
            child: Stack(
              children: <Widget>[
                // backgroundImage(2),
                // onTopContent(2),
                // BackdropFilter(
                //   filter: ImageFilter.blur(
                //     sigmaX: 2.1,
                //     sigmaY: 2.1,
                //   ),
                //   child: Container(
                //     color: Colors.black.withOpacity(0.0),
                //   ),
                // ),
              ],
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InvitationHistory()));
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(17.0),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Invitaciones de cortesia disponibles: 4",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                IconButton(
                  icon: Icon(Icons.info_outline),
                  onPressed: () {
                    _ackAlert(context);
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget backgroundImage(int i) {
    switch (i) {
      case 1:
        {
          return new Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    // colorFilter: new ColorFilter.mode(
                    //   Colors.black.withOpacity(0.6), BlendMode.luminosity),
                    image: AssetImage("lib/assets/images/invitations.jpeg"),
                    fit: BoxFit.cover)),
          );
        }
      case 2:
        {
          return new Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    // colorFilter: new ColorFilter.mode(
                    //   Colors.black.withOpacity(0.6), BlendMode.luminosity),
                    image:
                        AssetImage("lib/assets/images/invitation_history.jpg"),
                    fit: BoxFit.cover)),
          );
        }
        break;
      default:
    }
  }

  Widget onTopContent(int i) {
    switch (i) {
      case 1:
        {
          return new Positioned(
            right: 25.0,
            bottom: 20.0,
            child: Text(
              'Invitar amigos',
              style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24),
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          );
        }
      case 2:
        {
          return new Positioned(
            right: 25.0,
            bottom: 20.0,
            child: Text(
              'Ver historial \n de invitados',
              style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24),
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          );
        }

        break;
      default:
    }
  }

  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invitaciones de cortesia'),
          content: Container(
              width: ScreenUtil.getInstance().setWidth(140),
              child: Text(
                  'Las invitaciones de cortesia son invitaciones gratuitas que se renuevan mensualmente al pagar a tiempo su accion.',
                  style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(10)
                  ),)),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
