import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clubhub/UtilWidgets.dart';
import 'package:clubhub/assets/colors.dart';
import 'package:clubhub/models/invitations/InvitationModels.dart';
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

  List<GuestModel> guestsList = new List<GuestModel>();
  List<FriendModel> friendsList = new List<FriendModel>();

  var database = Firestore.instance;
  var friendsSize = 0;

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  List<DocumentSnapshot> _getFriends() {
    var result;
    database
        .collection('userFriends')
        .getDocuments()
        .then((snap) => {result = snap.documents});
    return result;
  }

  void _buildFriendsList() {
    List<DocumentSnapshot> list = _getFriends();
    var cid, docId, name;
    for (var i = 0; i < list.length; i++) {
      docId = list.elementAt(i).documentID;
      cid = list.elementAt(i).data['cid'];
      name = list.elementAt(i).data['name'];
      print('all good');
      friendsList.add(new FriendModel(docId, cid, name));
    }
  }

  @override
  void initState() {
    super.initState();
    _isVisible = false;
    guestsList.clear();
    friendsList.clear();
    _buildFriendsList();
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
                        child: showContinueButton(),
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
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Amigos',
              style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(18),
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(13),
        ),
        Container(
          height: ScreenUtil.getInstance().setHeight(260),
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
                thickness: 0.4,
              ),
              itemCount: friendsList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  enabled: !friendsList.elementAt(index).isSelected,
                  title: _buildFriendTile(
                      context, friendsList.elementAt(index), index),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFriendTile(BuildContext context, FriendModel friend, int index) {
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
          friend.name,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(12)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            width: 0.5,
            height: 17,
            color: const Color(0xFFB6B6B6),
          ),
        ),
        Text(
          'C.I. ' + friend.cid,
          style: TextStyle(
            fontSize: ScreenUtil.getInstance().setSp(10),
            color: const Color(0xFFB6B6B6),
          ),
        ),
      ],
    );
  }

  Widget showInvitedList() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Invitados',
              style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(18),
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(13),
        ),
        Container(
            height: ScreenUtil.getInstance().setHeight(180),
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
                  thickness: 0.4,
                ),
                itemCount: guestsList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: _buildInvitedTile(
                        context, guestsList.elementAt(index), index),
                  );
                },
              ),
            )),
      ],
    );
  }

  Widget _buildInvitedTile(BuildContext context, GuestModel friend, int index) {
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
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(12)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            width: 0.5,
            height: 17,
            color: const Color(0xFFB6B6B6),
          ),
        ),
        Text(
          'C.I. ' + friend.cid,
          style: TextStyle(
            fontSize: ScreenUtil.getInstance().setSp(10),
            color: const Color(0xFFB6B6B6),
          ),
        ),
      ],
    );
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

  Widget showAddToInviteListButton(FriendModel friend, int index) {
    return FloatingActionButton(
      heroTag: "addFriendBtn$index",
      backgroundColor: Colors.green,
      onPressed: () {
        addFriendToInviteList(friend, index);
      },
      child: Icon(Icons.add),
    );
  }

  Widget showRemoveFromFriendsListButton(FriendModel friend, int index) {
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
      onPressed: () {
        removeInvitedFromList(cid, index);
      },
      child: Icon(Icons.remove),
    );
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

  Widget showContinueButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        RaisedButton(
          child: Text('Continuar'),
          textColor: Colors.white,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        InvitationCheckout(invitedFriends: this.guestsList)));
          },
        ),
      ],
    );
  }

  void removeFriendFromList(FriendModel friend) {
    Firestore.instance
        .collection('userFriends')
        .document(friend.docId)
        .delete();
  }

  void addFriendToInviteList(FriendModel friend, int index) {
    GuestModel newGuest = new GuestModel(friend.docId, friend.name, friend.cid);
    setState(() {
      guestsList.add(newGuest);
      friend.isSelected = true;
    });
  }

  void removeInvitedFromList(String cid, int index) {
    setState(() {
      for (var i = 0; i < guestsList.length; i++) {
        if (guestsList.elementAt(i).cid == cid) {
          setState(() {
            setFriendUnselected(guestsList.elementAt(i).cid);
            guestsList.removeAt(i);
          });
        }
      }
    });
  }

  void setFriendUnselected(var cid) {
    for (var i = 0; i < friendsList.length; i++) {
      if (friendsList.elementAt(i).cid == cid) {
        friendsList.elementAt(i).isSelected = false;
      }
    }
  }
}
