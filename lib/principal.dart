import 'package:flutter/material.dart';

class Principal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, int i) {
        return Column(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                onTap: () {
                  // debugPrint("Hello");
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (BuildContext context) => ArticleDetail(
                  //       articles: techNews[i] == null
                  //           ? Text("Loading!")
                  //           : techNews[i],
                  //     ),
                  //   ),
                  // );
                },
                title: Container(
                  child: Stack(
                    alignment: AlignmentDirectional(0, 1),
                    children: <Widget>[
                      // Hero(
                      //   tag: techNews[i]['title'],
                      //   child: FadeInImage.assetNetwork(
                      //     placeholder: 'images/loading.gif',
                      //     image: techNews[i]['urlToImage'] == null
                      //         ? Image.asset(
                      //             'images/imgPlaceholder.png',
                      //           ).toString()
                      //         : techNews[i]['urlToImage'],
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Noticia'
                          // techNews[i]['title'] == null
                          //     ? Text("Title here").toString()
                          //     : techNews[i]['title'].toString(),
                          // textAlign: TextAlign.center,
                          // style: TextStyle(
                          //   color: Colors.white,
                          //   fontSize: 16.0,
                          //   fontWeight: FontWeight.w300,
                          //   backgroundColor: Colors.black26,
                          // ),
                        ),
                      ),
                    ],
                  ),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: FlatButton(
                        splashColor: Colors.black,
                        // color: Colors.black54,
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (BuildContext context) => ArticleDetail(
                          //       articles: techNews[i] == null
                          //           ? Text("Loading!")
                          //           : techNews[i],
                          //     ),
                          //   ),
                          // );
                        },
                        child: Text(
                          "Read More",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                onTap: () {
                  // debugPrint("Hello");
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (BuildContext context) => ArticleDetail(
                  //       articles: techNews[i] == null
                  //           ? Text("Loading!")
                  //           : techNews[i],
                  //     ),
                  //   ),
                  // );
                },
                title: Container(
                  child: Stack(
                    alignment: AlignmentDirectional(0, 1),
                    children: <Widget>[
                      // Hero(
                      //   tag: techNews[i]['title'],
                      //   child: FadeInImage.assetNetwork(
                      //     placeholder: 'images/loading.gif',
                      //     image: techNews[i]['urlToImage'] == null
                      //         ? Image.asset(
                      //             'images/imgPlaceholder.png',
                      //           ).toString()
                      //         : techNews[i]['urlToImage'],
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Noticia'
                          // techNews[i]['title'] == null
                          //     ? Text("Title here").toString()
                          //     : techNews[i]['title'].toString(),
                          // textAlign: TextAlign.center,
                          // style: TextStyle(
                          //   color: Colors.white,
                          //   fontSize: 16.0,
                          //   fontWeight: FontWeight.w300,
                          //   backgroundColor: Colors.black26,
                          // ),
                        ),
                      ),
                    ],
                  ),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: FlatButton(
                        splashColor: Colors.black,
                        // color: Colors.black54,
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (BuildContext context) => ArticleDetail(
                          //       articles: techNews[i] == null
                          //           ? Text("Loading!")
                          //           : techNews[i],
                          //     ),
                          //   ),
                          // );
                        },
                        child: Text(
                          "Read More",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                onTap: () {
                  // debugPrint("Hello");
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (BuildContext context) => ArticleDetail(
                  //       articles: techNews[i] == null
                  //           ? Text("Loading!")
                  //           : techNews[i],
                  //     ),
                  //   ),
                  // );
                },
                title: Container(
                  child: Stack(
                    alignment: AlignmentDirectional(0, 1),
                    children: <Widget>[
                      // Hero(
                      //   tag: techNews[i]['title'],
                      //   child: FadeInImage.assetNetwork(
                      //     placeholder: 'images/loading.gif',
                      //     image: techNews[i]['urlToImage'] == null
                      //         ? Image.asset(
                      //             'images/imgPlaceholder.png',
                      //           ).toString()
                      //         : techNews[i]['urlToImage'],
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Noticia'
                          // techNews[i]['title'] == null
                          //     ? Text("Title here").toString()
                          //     : techNews[i]['title'].toString(),
                          // textAlign: TextAlign.center,
                          // style: TextStyle(
                          //   color: Colors.white,
                          //   fontSize: 16.0,
                          //   fontWeight: FontWeight.w300,
                          //   backgroundColor: Colors.black26,
                          // ),
                        ),
                      ),
                    ],
                  ),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: FlatButton(
                        splashColor: Colors.black,
                        // color: Colors.black54,
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (BuildContext context) => ArticleDetail(
                          //       articles: techNews[i] == null
                          //           ? Text("Loading!")
                          //           : techNews[i],
                          //     ),
                          //   ),
                          // );
                        },
                        child: Text(
                          "Read More",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                onTap: () {
                  // debugPrint("Hello");
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (BuildContext context) => ArticleDetail(
                  //       articles: techNews[i] == null
                  //           ? Text("Loading!")
                  //           : techNews[i],
                  //     ),
                  //   ),
                  // );
                },
                title: Container(
                  child: Stack(
                    alignment: AlignmentDirectional(0, 1),
                    children: <Widget>[
                      // Hero(
                      //   tag: techNews[i]['title'],
                      //   child: FadeInImage.assetNetwork(
                      //     placeholder: 'images/loading.gif',
                      //     image: techNews[i]['urlToImage'] == null
                      //         ? Image.asset(
                      //             'images/imgPlaceholder.png',
                      //           ).toString()
                      //         : techNews[i]['urlToImage'],
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Noticia'
                          // techNews[i]['title'] == null
                          //     ? Text("Title here").toString()
                          //     : techNews[i]['title'].toString(),
                          // textAlign: TextAlign.center,
                          // style: TextStyle(
                          //   color: Colors.white,
                          //   fontSize: 16.0,
                          //   fontWeight: FontWeight.w300,
                          //   backgroundColor: Colors.black26,
                          // ),
                        ),
                      ),
                    ],
                  ),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: FlatButton(
                        splashColor: Colors.black,
                        // color: Colors.black54,
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (BuildContext context) => ArticleDetail(
                          //       articles: techNews[i] == null
                          //           ? Text("Loading!")
                          //           : techNews[i],
                          //     ),
                          //   ),
                          // );
                        },
                        child: Text(
                          "Read More",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                onTap: () {
                  // debugPrint("Hello");
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (BuildContext context) => ArticleDetail(
                  //       articles: techNews[i] == null
                  //           ? Text("Loading!")
                  //           : techNews[i],
                  //     ),
                  //   ),
                  // );
                },
                title: Container(
                  child: Stack(
                    alignment: AlignmentDirectional(0, 1),
                    children: <Widget>[
                      // Hero(
                      //   tag: techNews[i]['title'],
                      //   child: FadeInImage.assetNetwork(
                      //     placeholder: 'images/loading.gif',
                      //     image: techNews[i]['urlToImage'] == null
                      //         ? Image.asset(
                      //             'images/imgPlaceholder.png',
                      //           ).toString()
                      //         : techNews[i]['urlToImage'],
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Noticia'
                          // techNews[i]['title'] == null
                          //     ? Text("Title here").toString()
                          //     : techNews[i]['title'].toString(),
                          // textAlign: TextAlign.center,
                          // style: TextStyle(
                          //   color: Colors.white,
                          //   fontSize: 16.0,
                          //   fontWeight: FontWeight.w300,
                          //   backgroundColor: Colors.black26,
                          // ),
                        ),
                      ),
                    ],
                  ),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: FlatButton(
                        splashColor: Colors.black,
                        // color: Colors.black54,
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (BuildContext context) => ArticleDetail(
                          //       articles: techNews[i] == null
                          //           ? Text("Loading!")
                          //           : techNews[i],
                          //     ),
                          //   ),
                          // );
                        },
                        child: Text(
                          "Read More",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                onTap: () {
                  // debugPrint("Hello");
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (BuildContext context) => ArticleDetail(
                  //       articles: techNews[i] == null
                  //           ? Text("Loading!")
                  //           : techNews[i],
                  //     ),
                  //   ),
                  // );
                },
                title: Container(
                  child: Stack(
                    alignment: AlignmentDirectional(0, 1),
                    children: <Widget>[
                      // Hero(
                      //   tag: techNews[i]['title'],
                      //   child: FadeInImage.assetNetwork(
                      //     placeholder: 'images/loading.gif',
                      //     image: techNews[i]['urlToImage'] == null
                      //         ? Image.asset(
                      //             'images/imgPlaceholder.png',
                      //           ).toString()
                      //         : techNews[i]['urlToImage'],
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Noticia'
                          // techNews[i]['title'] == null
                          //     ? Text("Title here").toString()
                          //     : techNews[i]['title'].toString(),
                          // textAlign: TextAlign.center,
                          // style: TextStyle(
                          //   color: Colors.white,
                          //   fontSize: 16.0,
                          //   fontWeight: FontWeight.w300,
                          //   backgroundColor: Colors.black26,
                          // ),
                        ),
                      ),
                    ],
                  ),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: FlatButton(
                        splashColor: Colors.black,
                        // color: Colors.black54,
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (BuildContext context) => ArticleDetail(
                          //       articles: techNews[i] == null
                          //           ? Text("Loading!")
                          //           : techNews[i],
                          //     ),
                          //   ),
                          // );
                        },
                        child: Text(
                          "Read More",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

