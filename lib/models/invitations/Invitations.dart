import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:clubhub/addFriend.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'invitationCheckout.dart';

var invitedList = <Map>[];

class Invitations extends StatefulWidget {
  final String friendsListId;

  Invitations({this.friendsListId});

  @override
  _InvitationsState createState() => _InvitationsState();
}

class _InvitationsState extends State<Invitations> {

  // bool[] _isVisible = [];

  void _listTileChangeState(){}

  // Future _getFriends() async {
  //   var firestore = Firestore.instance;
  //   DocumentSnapshot qn = await firestore
  //       .collection('userFriends')
  //       .document(widget.friendsListId).get();
  //   return qn;
  // }

  // _fromInviteListToFriendsList(Map friends) {

  // }



  @override
  Widget build(BuildContext context) {
    var userFriendsList = Firestore.instance.collection('userFriends').document(widget.friendsListId).get();

    _fromFrientsListToInviteList(Map friend) {
      invitedList.add(friend);
      // userFriendsList
    }

    return Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Text(
                "Invitados",
                style: TextStyle(fontSize: ScreenUtil().setSp(80)),
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),
              Container(
                width: ScreenUtil().setWidth(420),
                height: ScreenUtil().setHeight(260),
                // child: _invitedListView(),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.grey,
                  width: 2.0,
                )),
              ),
              SizedBox(height: ScreenUtil().setHeight(40)),
              Text(
                "Amigos",
                style: TextStyle(fontSize: ScreenUtil().setSp(80)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: ScreenUtil().setWidth(420),
                height: ScreenUtil().setHeight(260),
                // child: _friendsListView(),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.grey,
                  width: 2.0,
                )),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Agregar', style: TextStyle(fontSize: 20)),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddFriend()));
                    },
                  ),
                  RaisedButton(
                    child: Text('Continuar', style: TextStyle(fontSize: 20)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InvitationCheckout()));
                    },
                  )
                ],
              )
            ],
          ),
        ));
  }

//   Widget _buildItem(String item, Animation animation) {
//     return SizeTransition(
//       sizeFactor: animation,
//       child: Card(
//         child: ListTile(
//           title: Text(
//             item,
//             style: TextStyle(fontSize: 20),
//           ),
//         ),
//       ),
//     );
//   }

//   void _insertSingleItem() {
//     String newItem = "Planet";
//     // Arbitrary location for demonstration purposes
//     int insertIndex = 2;
//     // Add the item to the data list.
//     //_data.insert(insertIndex, newItem);
//     // Add the item visually to the AnimatedList.
//     //_listKey.currentState.insertItem(insertIndex);
//   }

//   void _removeSingleItem() {
//     int removeIndex = 2;
//     // Remove item from data list but keep copy to give to the animation.
//     //String removedItem = _data.removeAt(removeIndex);
//     // This builder is just for showing the row while it is still
//     // animating away. The item is already gone from the data list.
//     AnimatedListRemovedItemBuilder builder = (context, animation) {
//       //return _buildItem(removedItem, animation);
//     };
//     // Remove the item visually from the AnimatedList.
//     //_listKey.currentState.removeItem(removeIndex, builder);
//   }

//   Widget _invitedListView() {
//     return ListView.separated(
//       itemCount: _invitedListSize(),
//       itemBuilder: (context, index) {
//         var item = invitedList[index];

//         return Dismissible(
//           key: Key(item),
//           onDismissed: (direction) {
//             setState(() {
//               friendsList.add(item);
//               invitedList.removeAt(index);
//             });

//             Scaffold.of(context)
//                 .showSnackBar(SnackBar(content: Text("$item dismissed")));
//           },
//           background: Container(color: Colors.red),
//           child: ListTile(title: Text("$item")),
//         );
//       },
//       separatorBuilder: (context, index) {
//         return Divider();
//       },
//     );
//   }

//   Widget _friendsListView() {
//     return ListView.separated(
//       itemCount: _friendsListSize(),
//       itemBuilder: (context, index) {
//         var item = friendsList[index];

//         return Dismissible(
//           key: Key(item),
//           onDismissed: (direction) {
//             setState(() {
//               invitedList.add(item);
//               friendsList.removeAt(index);
//             });

//             Scaffold.of(context)
//                 .showSnackBar(SnackBar(content: Text("$item dismissed")));
//           },
//           background: Container(color: Colors.green),
//           child: ListTile(title: Text("$item")),
//         );
//       },
//       separatorBuilder: (context, index) {
//         return Divider();
//       },
//     );
//   }

//   int _friendsListSize() {
//     if (friendsList.isEmpty)
//       return 0;
//     else
//       return friendsList.length;
//   }

//   int _invitedListSize() {
//     if (invitedList.isEmpty)
//       return 0;
//     else
//       return invitedList.length;
//   }
// }

// void addFriendToList() {
//   friendsList.add("Nuevo amigo");
// }

// int invitedListSize() {
//   if (invitedList.isEmpty)
//     return 0;
//   else
//     return invitedList.length;
}
