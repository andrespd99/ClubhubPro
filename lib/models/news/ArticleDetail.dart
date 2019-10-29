import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clubhub/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArticleDetail extends StatefulWidget {
  final DocumentSnapshot article;

  ArticleDetail({this.article});

  @override
  _ArticleDetailState createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: kClubhubBlue400,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 12.0, 0.0, 15.0),
              child: Hero(
                tag: widget.article.data['title'],
                child: Text(
                  widget.article.data['title'],
                  style: TextStyle(
                    fontFamily: 'Poppins-Medium',
                    fontSize: ScreenUtil().setSp(45),
                    color: kClubhubBlueDark,
                  ),
                ),
              ),
            ),
            Hero(
              tag: widget.article.documentID,
              child: Image(
                image: NetworkImage(widget.article.data['thumbnailUrl']),
                width: MediaQuery.of(context).size.width,
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(80),
              child: Stack(
                children: <Widget>[
                  Positioned(
                      right: 15.0,
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.share),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.bookmark_border),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Divider(),
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(17.0, 3.0, 17.0, 30.0),
                child: Text(
                  widget.article.data['content'],
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(30),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
