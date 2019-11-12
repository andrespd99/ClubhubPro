import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvitationHistory extends StatefulWidget {
  InvitationHistory({Key key}) : super(key: key);

  @override
  _InvitationHistoryState createState() => _InvitationHistoryState();
}

class _InvitationHistoryState extends State<InvitationHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                  child: Text(
                    'Historial de Invitaciones',
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(43),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                FutureBuilder(
                  // builder: ,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
