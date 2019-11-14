import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clubhub/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArticleDetail extends StatefulWidget {
  DocumentSnapshot article;

  ArticleDetail({Key key, this.article}) : super(key: key);

  @override
  _ArticleDetailState createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  void _bookmarkIconStateChanger(bool isBookmarked, DocumentSnapshot article) {
    setState(() {
      article.data['isBookmarked'] = !isBookmarked;
    });
    print(article.data['isBookmarked']);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            articleTitle(widget.article),
            articleImageSection(widget.article),
            articleContentSection(widget.article),
          ],
        ),
      ),
    );
  }

  Widget articleTitle(DocumentSnapshot article) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 0.0, 15.0),
      child: Text(
        widget.article.data['title'],
        style: TextStyle(
          fontSize: ScreenUtil.getInstance().setSp(18),
          color: kClubhubBlueDark,
        ),
      ),
    );
  }

  Widget articleImageSection(DocumentSnapshot article) {
    return Column(
      children: <Widget>[
        Hero(
          tag: widget.article.documentID,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xfff2f2f2),
            ),
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: FittedBox(
              child: CachedNetworkImage(
                placeholder: (context, url) => CircularProgressIndicator(),
                imageUrl: widget.article.data['thumbnailUrl'],
              ),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Container(
          height: ScreenUtil().setHeight(80),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: showBookmarker(widget.article),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget articleContentSection(DocumentSnapshot article) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(17.0, 3.0, 17.0, 30.0),
        child: Text(
          widget.article.data['content'],
          style: TextStyle(
            fontSize: ScreenUtil().setSp(14),
          ),
        ),
      ),
    );
  }

  Widget showBookmarker(DocumentSnapshot article) {
    return ClipOval(
      child: Container(
        width: 44.0,
        height: 44.0,
        color: Colors.white,
        child: InkWell(
          child: Visibility(
            visible: article.data['isBookmarked'],
            replacement: Icon(Icons.bookmark_border),
            child: Icon(Icons.bookmark),
          ),
          onTap: () {
            _bookmarkIconStateChanger(article.data['isBookmarked'], article);
          },
        ),
      ),
    );
  }
}
