import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clubhub/UtilWidgets.dart';
import 'package:clubhub/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvitationHistory extends StatefulWidget {
  InvitationHistory({Key key}) : super(key: key);

  @override
  _InvitationHistoryState createState() => _InvitationHistoryState();
}

class _InvitationHistoryState extends State<InvitationHistory> {
  Future _data;

  Future _getPosts() async {
    var firestore = Firestore.instance;

    QuerySnapshot qn = await firestore.collection('news').getDocuments();

    return qn.documents;
  }

  @override
  void initState() {
    super.initState();
    _data = _getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 15.0),
                  child: Text(
                    'Historial de Invitaciones',
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(43),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            FutureBuilder(
                future: _data,
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return showLoadingCircle();
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, index) {
                          return ListTile(
                            title: _buildHistoryItem(
                                context, snapshot.data[index]),
                          );
                        });
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(
      BuildContext context, DocumentSnapshot historySnapshot) {
    return Container(
      width: 200,
      height: ScreenUtil.getInstance().setHeight(132),
      child: Row(
        children: <Widget>[
          Text('Prueba'),
          // _leftSection(historySnapshot),
          // _middleSection(historySnapshot),
          // _rightSection(historySnapshot),
        ],
      ),
      decoration: BoxDecoration(
          border: Border.all(width: 1.5, color: kClubhubTextPrimary)),
    );
  }

  Widget _leftSection(DocumentSnapshot historySnapshot) {
    return Container(
      width: ScreenUtil.getInstance().width * 0.34,
      height: 129,
      child: Center(
        child: Placeholder(),
      ),
    );
  }

  Widget _middleSection(DocumentSnapshot historySnapshot) {
    return Container(
      width: ScreenUtil.getInstance().width * 0.61,
      height: 129,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              //TO-DO: Mostrar lista de las personas invitadas en la fecha.
            ],
          ),
          Text(
            historySnapshot.data['date'],
            style: TextStyle(
                color: kClubhubButtonDark2,
                fontSize: ScreenUtil.getInstance().setSp(11)),
          )
        ],
      ),
    );
  }

  Widget _rightSection(DocumentSnapshot historySnapshot) {}
}
