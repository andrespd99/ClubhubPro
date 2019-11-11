import 'dart:ui';
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
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);

    // full screen width and height
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // height without SafeArea

    return Column(
      children: <Widget>[
        //Contenedor registrar invitados
        Expanded(
          child: InkWell(
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  child: Image.asset(
                    "lib/assets/images/register_invite_image.jpg",
                    height: ScreenUtil.getInstance().setHeight(500),
                    fit: BoxFit.cover,
                  ),
                ),
                // BackdropFilter(
                //   filter: ImageFilter.blur(
                //     sigmaX: 2.1,
                //     sigmaY: 2.1,
                //   ),
                //   child: Container(
                //     color: Colors.black.withOpacity(0.0),
                //   ),
                // ),
                Positioned(
                  bottom: 15.0,
                  right: 10.0,
                  child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Registrar invitados',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 33.0,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(4.0, 5.0),
                                blurRadius: 25.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ]),
                      )),
                )
              ],
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Invitations()));
            },
          ),
        ),
        //Contenedor Historial de invitados
        Expanded(
          child: InkWell(
            child: Stack(
              children: <Widget>[
                FittedBox(
                  child: Image.asset(
                    "lib/assets/images/invitation_history.jpg",
                    fit: BoxFit.fitWidth,
                  ),
                ),
                // BackdropFilter(
                //   filter: ImageFilter.blur(
                //     sigmaX: 2.1,
                //     sigmaY: 2.1,
                //   ),
                //   child: Container(
                //     color: Colors.black.withOpacity(0.0),
                //   ),
                // ),
                Positioned(
                  bottom: 15.0,
                  right: 10.0,
                  child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Historial de \n invitados',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 33.0,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(4.0, 5.0),
                                blurRadius: 25.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ]),
                      )),
                )
              ],
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Invitations()));
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
                Icon(Icons.info_outline)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
