import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clubhub/UtilWidgets.dart';
import 'package:clubhub/assets/colors.dart';
import 'package:clubhub/models/invitations/FriendInvited.dart';
import 'package:clubhub/models/invitations/addFriend.dart';
import 'package:clubhub/models/invitations/invitationCheckout.dart';
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

  List<FriendInvited> listOfInvited = new List<FriendInvited>();

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    _isVisible = false;
    listOfInvited.clear();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Invitar"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 0.0),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        showFriendsList(),
                        showAddToFriendsListButton(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        showEditButton(),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 15.0),
                  child: Column(
                    children: <Widget>[
                      showInvitedList(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 10.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            RaisedButton(
                              child: Text('Continuar'),
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.push(context, 
                                MaterialPageRoute(builder: (context) => InvitationCheckout(invitedFriends: this.listOfInvited)));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget showFriendsList() {
    return Container(
      height: ScreenUtil.getInstance().setHeight(470),
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
                          context, snapshot.data.documents[index], index),
                    );
                  },
                ),
              );
            }
          }),
    );
  }

  Widget _buildFriendTile(
      BuildContext context, DocumentSnapshot friend, int index) {
    return Row(
      children: <Widget>[
        Container(
          width: 28.0,
          height: 28.0,
          child: Visibility(
            visible: _isVisible,
            replacement: showAddToInviteListButton(friend, index),
            child: showRemoveFromFriendsListButton(friend, index),
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

  Widget showInvitedList() {
    return Container(
        height: ScreenUtil.getInstance().setHeight(400),
        decoration: BoxDecoration(
            border: Border.all(
          color: Colors.black12,
          width: 1.5,
        )),
        child: Scrollbar(
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: kClubhubTextPrimary,
              indent: 15.0,
              endIndent: 15.0,
            ),
            itemCount: listOfInvited.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: _buildInvitedTile(
                    context, listOfInvited.elementAt(index), index),
              );
            },
          ),
        ));
  }

  Widget _buildInvitedTile(
      BuildContext context, FriendInvited friend, int index) {
    return Row(
      children: <Widget>[
        Container(
          width: 28.0,
          height: 28.0,
          child: showRemoveFromInviteListButton(friend.cid, index),
        ),
        SizedBox(width: ScreenUtil.getInstance().setWidth(10)),
        Text(
          friend.name,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(25)),
        ),
        SizedBox(width: ScreenUtil.getInstance().setWidth(30)),
        Text(
          friend.cid,
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

  Widget showAddToFriendsListButton() {
    return Positioned(
      bottom: 20.0,
      right: 20.0,
      child: Visibility(
        visible: !_isVisible,
        child: Container(
          width: 45.0,
          height: 45.0,
          child: FloatingActionButton(
            backgroundColor: kClubhubBlueMain,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddFriend()));
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Widget showAddToInviteListButton(DocumentSnapshot friend, int index) {
    return FloatingActionButton(
      heroTag: "addFriendBtn$index",
      backgroundColor: Colors.green,
      onPressed: () {
        addFriendToInviteList(friend);
      },
      child: Icon(Icons.add),
    );
  }

  Widget showRemoveFromFriendsListButton(DocumentSnapshot friend, int index) {
    return FloatingActionButton(
      heroTag: "removeFriendBtn$index",
      backgroundColor: Colors.redAccent,
      onPressed: () => {removeFriendFromList(friend)},
      child: Icon(Icons.remove),
    );
  }

  Widget showRemoveFromInviteListButton(String cid, int index) {
    return FloatingActionButton(
      heroTag: "removeInvitedBtn$index",
      backgroundColor: Colors.redAccent,
      onPressed: () => {removeInvitedFromList(cid)},
      child: Icon(Icons.remove),
    );
  }

  void addFriendToInviteList(DocumentSnapshot friend) {
    FriendInvited newInvited =
        new FriendInvited(friend.data['name'], friend.data['cid']);
    setState(() {
      listOfInvited.add(newInvited);
    });
  }

  removeInvitedFromList(String cid) {
    setState(() {
      for (var i = 0; i < listOfInvited.length; i++) {
        if (listOfInvited.elementAt(i).cid == cid) {
          setState(() {
            listOfInvited.removeAt(i);
          });
        }
      }
    });
  }

  Widget showEditButton() {
    return FlatButton(
      child: Text('Editar'),
      textColor: kClubhubBlueDark,
      onPressed: () {
        _toggleVisibility();
      },
    );
  }
}
