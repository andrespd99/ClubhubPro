import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clubhub/UtilWidgets.dart';
import 'package:clubhub/assets/colors.dart';
import 'package:clubhub/models/news/ArticleDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class News extends StatefulWidget {
  News({Key key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  Future _data;

  Future _getPosts() async {
    var firestore = Firestore.instance;

    QuerySnapshot qn = await firestore.collection('news').getDocuments();

    return qn.documents;
  }

  void _bookmarkIconStateChanger(bool isBookmarked, DocumentSnapshot article) {
    setState(() {
      article.data['isBookmarked'] = !isBookmarked;
    });
    print(article.data['isBookmarked']);
  }

  @override
  void initState() {
    super.initState();
    _data = _getPosts();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: _data,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return showLoadingCircle();
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return SingleChildScrollView(
                                          child: ListTile(
                        title: _buildListItem(context, snapshot.data[index]),
                        onTap: () {
                          _navigateToDetail(snapshot.data[index]);
                        },
                      ),
                    );
                  });
            }
          }),
    );
  }

    Widget _buildListItem(BuildContext context, DocumentSnapshot article) {
    return Column(
      children: <Widget>[
        showArticleTitle(article),
        showArticleImage(article, context),
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(50),
        ),
        Divider()
      ],
    );
  }

  Widget showArticleImage(DocumentSnapshot article, BuildContext context) {
    return Stack(
      children: <Widget>[
        Hero(
          tag: article.documentID,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xfff2f2f2),
            ),
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: FittedBox(
              child: CachedNetworkImage(
                imageUrl: article.data['thumbnailUrl'],
                placeholder: (context, url) => CircularProgressIndicator(),
                //                 FadeInImage.assetNetwork(
                //   placeholder: 'lib/assets/images/loading.gif',
                //   image: article.data['thumbnailUrl'],
                // ),
              ),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Positioned(
          bottom: 20.0,
          right: 15.0,
          child: showBookmarker(article),
        )
      ],
    );
  }

  Widget showBookmarker(DocumentSnapshot article) {
    return ClipOval(
      child: Container(
        width: ScreenUtil.getInstance().setWidth(65),
        height: ScreenUtil.getInstance().setHeight(65),
        color: Colors.white,
        child: InkWell(
          child: Visibility(
            visible: article.data['isBookmarked'],
            replacement: Icon(Icons.bookmark_border, size: ScreenUtil.getInstance().setWidth(60),),
            child: Icon(Icons.bookmark),
          ),
          onTap: () {
            _bookmarkIconStateChanger(article.data['isBookmarked'], article);
          },
        ),
      ),
    );
  }

  Widget showArticleTitle(DocumentSnapshot article) {
    return Padding(
      padding: EdgeInsets.fromLTRB(7.0, 0, 0, 5.0),
      child: Hero(
        tag: article.data['title'],
        child: Text(
          article.data['title'],
          textAlign: TextAlign.left,
          style: TextStyle(
            //fontSize: ScreenUtil().setSp(40),
            color: kClubhubBlueDark,
          ),
        ),
      ),
    );
  }

  void _navigateToDetail(DocumentSnapshot article) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ArticleDetail(article: article)));
    }
}