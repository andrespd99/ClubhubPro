import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clubhub/assets/colors.dart';
import 'package:clubhub/models/news/ArticleDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Bookmarks extends StatefulWidget {
  Bookmarks({Key key}) : super(key: key);

  @override
  _BookmarksState createState() => _BookmarksState();
}

class ArticleModel {
  String title, imageUrl, content, id;
  bool isBookmarked;

  ArticleModel(
      this.id, this.title, this.imageUrl, this.content, this.isBookmarked);
}

class _BookmarksState extends State<Bookmarks> {
  var database = Firestore.instance;
  List<ArticleModel> _bookmarks = new List<ArticleModel>();

  void _getBookmarkedArticles() {
    ArticleModel newArticle;
    var article;
    bool isBookmarked;
    database.collection('news').getDocuments().then((snap) => {
          for (var i = 0; i < snap.documents.length; i++)
            {
              article = snap.documents.elementAt(i),
              isBookmarked = article.data['isBookmarked'],
              if (isBookmarked)
                {
                  newArticle = new ArticleModel(
                      article.documentID,
                      article.data['title'],
                      article.data['thumbnailUrl'],
                      article.data['content'],
                      article.data['isBookmarked']),
                  _bookmarks.add(newArticle),
                }
            }
        });
  }

  @override
  void initState() {
    super.initState();
    _getBookmarkedArticles();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);

    return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Column(children: <Widget>[
            bookmarkViewTitle(),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(74),
            ),
            bookmarkList(),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(74),
            ),
            Text(
              'No hay mas publicaciones...',
              style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(15)),
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  
                });
              },
            )
          ]),
        ));
  }

  Widget leadingSection(ArticleModel article) {
    return Expanded(
      child: Container(
        child: Hero(
          tag: article.id,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xfff2f2f2),
            ),
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: FittedBox(
              child: CachedNetworkImage(
                placeholder: (context, url) => CircularProgressIndicator(),
                imageUrl: article.imageUrl,
              ),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
      flex: 3,
    );
  }

  Widget trailingSection(ArticleModel article) {
    return Expanded(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(9.0, 8.0, 14.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                article.title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil.getInstance().setSp(11)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      'Ver mas',
                      style: TextStyle(color: kClubhubBlueDark),
                    ),
                    onPressed: () {
                      database
                          .collection('news')
                          .document(article.id)
                          .get()
                          .then((snap) => {_navigateToDetail(snap)});
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
      flex: 4,
    );
  }

  Widget bookmarkViewTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 15.0),
          child: Text(
            'Noticias guardadas',
            style: TextStyle(
                fontSize: ScreenUtil.getInstance().setSp(21),
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget bookmarkList() {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: _bookmarks.length,
          itemBuilder: (_, index) {
            return Container(
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(width: 0.5, color: kClubhubTextPrimary),
              )),
              height: ScreenUtil.getInstance().height * 0.1527,
              child: Row(
                children: <Widget>[
                  leadingSection(_bookmarks.elementAt(index)),
                  trailingSection(_bookmarks.elementAt(index)),
                ],
              ),
              
            );
          }),
    );
  }

  void _navigateToDetail(DocumentSnapshot article) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ArticleDetail(article: article)));
  }
}
