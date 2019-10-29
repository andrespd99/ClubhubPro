import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clubhub/assets/colors.dart';
import 'package:clubhub/models/news/ArticleDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Icon _bookmarkIconState = new Icon(Icons.bookmark_border);

class News extends StatefulWidget {
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

  @override
  void initState() {
    super.initState();

    _data = _getPosts();
  }

  @override
  Widget build(BuildContext context) {
    _navigateToDetail(DocumentSnapshot article) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ArticleDetail(article: article)));
    }

    return Container(
      child: FutureBuilder(
          future: _data,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("Cargando...",
                        style: TextStyle(
                            color: kClubhubBlueDark,
                            fontFamily: 'Poppins-Medium'))
                  ],
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      title: _buildListItem(context, snapshot.data[index]),
                      onTap: () {
                        _navigateToDetail(snapshot.data[index]);
                      },
                    );
                  });
            }
          }),
    );
  }
}

Widget _buildListItem(BuildContext context, DocumentSnapshot article) {
  _bookmarkIconStateChanger() {
    _bookmarkIconState = new Icon(Icons.bookmark);
  }

  return Column(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(7.0, 0, 0, 5.0),
        child: Hero(
          tag: article.data['title'],
          child: Text(
            article.data['title'],
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Poppins-Medium',
              fontSize: ScreenUtil().setSp(40),
              color: kClubhubBlueDark,
            ),
          ),
        ),
      ),
      Stack(
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
                child: FadeInImage.assetNetwork(
                  placeholder: 'lib/assets/images/loading.gif',
                  image: article.data['thumbnailUrl'],
                ),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
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
      ),
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
