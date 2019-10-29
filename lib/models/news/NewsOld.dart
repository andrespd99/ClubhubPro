import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:clubhub/assets/colors.dart';

final fsRef = FirebaseStorage.instance;
final databaseRef = Firestore.instance;

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  List news = [];
  // // Variables
  // FirebaseUser currentUser;
  // FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Future<QuerySnapshot> 
  
  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}

Widget _buildBody(BuildContext context) {
  return Container();
  // return ListView.builder(
  //   itemCount: ,
  // );
  // return StreamBuilder<QuerySnapshot>(
  //   stream: Firestore.instance.collection('news').orderBy('date').snapshots(),
  //   builder: (context, snapshot) {
  //     if (!snapshot.hasData) return CircularProgressIndicator();

  //     return _buildList(context, snapshot.data.documents);
  //   },
  // );
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
    padding: const EdgeInsets.only(top: 20.0),
    children: snapshot.map((data) => _buildListItem(context, data)).toList(),
  );
}

Icon _bookmarkIconState = new Icon(Icons.bookmark_border);

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  _bookmarkIconStateChanger() {
    _bookmarkIconState = new Icon(Icons.bookmark);
  }

  final Record record = Record.fromSnapshot(data);

  return Column(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(15.0, 0, 0, 5.0),
        child: Text(
        record.title,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtil().setSp(50),
          color: kClubhubBlueDark,
        ),
      ),),
      Container(
          width: MediaQuery.of(context).size.width,
          height: ScreenUtil().setHeight(750),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(record.thumbnailUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 20.0,
                right: 15.0,
                child: ClipOval(
                  child: Container(
                    // width: ScreenUtil().setWidth(90),
                    // height: ScreenUtil().setHeight(90),
                    width: 44.0,
                    height: 44.0,
                    color: Colors.white,
                    child: InkWell(
                      child: _bookmarkIconState,
                      onTap: () {
                        _bookmarkIconStateChanger();
                      },
                    ),
                  ),
                ),
              )
            ],
          )),
      SizedBox(
        height: ScreenUtil().setHeight(50),
      ),
      Divider()
    ],
  );

  // return Padding(
  //   key: ValueKey(record.title),
  //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  //   child: Container(
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Colors.grey),
  //       borderRadius: BorderRadius.circular(5.0),
  //     ),
  //     child: ListTile(
  //       title: Stack(
  //         children: <Widget>[
  //           Container(
  //             child: Image(
  //               image: NetworkImage(record.thumbnailUrl),
  //               fit: BoxFit.fitWidth,
  //             ),
  //           ),
  //           Text(record.title),
  //         ],
  //       ),
  //       onTap: () => print(record),
  //     ),
  //   ),
  // );
}

class Record {
  final String title;
  final String thumbnailUrl;
  final String content;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['title'] != null),
        assert(map['thumbnailUrl'] != null),
        assert(map['content'] != null),
        title = map['title'],
        thumbnailUrl = map['thumbnailUrl'],
        content = map['content'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$title:$thumbnailUrl>";
}
