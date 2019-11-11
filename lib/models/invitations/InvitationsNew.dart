import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clubhub/UtilWidgets.dart';
import 'package:clubhub/assets/colors.dart';
import 'package:clubhub/models/invitations/addFriend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Invitations extends StatefulWidget {
  final String friendsListId;

  Invitations({this.friendsListId});

  @override
  _InvitationsState createState() => _InvitationsState();
}

class _InvitationsState extends State<Invitations> {
  bool _isVisible = false;
  Future _data;

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  Future _getFriends() async {
    var firestore = Firestore.instance;

    QuerySnapshot qn = await firestore.collection('userFriends').getDocuments();

    return qn.documents;
  }

  @override
  void initState() {
    super.initState();
    _isVisible = false;
    _data = _getFriends();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Future<DocumentSnapshot> map = Firestore.instance.collection('userFriends').document(widget.friendsListId).snapshots().elementAt(index);

    return Scaffold(
      appBar: AppBar(
        title: Text("Invitaciones"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 0.0),
                  child: Container(
                    height: 200.0,
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.black12,
                      width: 1.5,
                    )),
                    child: Placeholder(),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 0.0),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        showFriendsList(),
                        showAddButton(),
                      ],
                    ),
                    ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: Text('Editar'),
                          textColor: kClubhubBlueDark,
                          onPressed: () {
                            _toggleVisibility();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showFriendsList() {
    return Container(
      height: 200.0,
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.black12,
        width: 1.5,
      )),
      child: StreamBuilder(
          stream: Firestore.instance.collection('userFriends').snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            var documents = snapshot.data.documents;
            if (!snapshot.hasData) {
              return showLoadingCircle();
            } else {
              return Scrollbar(
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: kClubhubTextPrimary,
                    indent: 15.0,
                    endIndent: 15.0,
                  ),
                  itemCount: documents.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      title: _buildFriendTile(
                          context, snapshot.data.documents[index]),
                    );
                  },
                ),
              );
            }
          }),
    );
  }

  Widget _buildFriendTile(BuildContext context, DocumentSnapshot friend) {
    return Row(
      children: <Widget>[
        Container(
          width: 28.0,
          height: 28.0,
          child: Visibility(
            visible: _isVisible,
            replacement: showAddToInviteListButton(friend),
            // child: ClipOval(
            //   child: Container(
            //     decoration: BoxDecoration(
            //         color: Colors.redAccent,
            //         border: Border.all(color: Colors.black, width: 1.0)),
            //     child: Icon(Icons.remove, color: Colors.white),
            //   ),
            // ),
            child: showRemoveFromFriendsListButton(friend),
          ),
        ),
        SizedBox(width: ScreenUtil.getInstance().setWidth(10)),
        Text(
          friend.data['name'],
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(25)),
        ),
        SizedBox(width: ScreenUtil.getInstance().setWidth(30)),
        Text(
          friend.data['cid'],
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(25)),
        ),
      ],
    );
  }

  removeFriendFromList(DocumentSnapshot friend) {
    Firestore.instance
        .collection('userFriends')
        .document(friend.documentID)
        .delete();
  }

  Widget showAddButton() {
    return Positioned(
      bottom: 20.0,
      right: 20.0,
      child: Container(
        width: 45.0,
        height: 45.0,
        child: FloatingActionButton(
          backgroundColor: kClubhubBlueMain,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddFriend()));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget showAddToInviteListButton(DocumentSnapshot friend) {
    return FloatingActionButton(
      backgroundColor: Colors.green,
      onPressed: () {
        addFriendToInviteList(friend);
              },
              child: Icon(Icons.add),
            );
          }
        
          Widget showRemoveFromFriendsListButton(DocumentSnapshot friend) {
            return FloatingActionButton(
              backgroundColor: Colors.redAccent,
              onPressed: () => {removeFriendFromList(friend)},
              child: Icon(Icons.remove),
            );
          }
        
          void addFriendToInviteList(DocumentSnapshot friend) {

          }
}
