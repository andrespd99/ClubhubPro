import 'package:flutter/material.dart';
import 'addFriend.dart';
import 'invitationCheckout.dart';

var invitedList = <String>[];
var friendsList = List<String>.generate(6, (i) => "Amigo $i");

class Invitaciones extends StatefulWidget {
  InvitacionesState createState() => InvitacionesState();
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
    );
  }
}

class InvitacionesState extends State<Invitaciones> {

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Padding (
          padding: EdgeInsets.all(20.0),
          child: Column(
          children: <Widget>[
            Text(
              "Invitados",
              style: TextStyle(fontSize: 35.0),
            ),
            SizedBox(height: 20.0,),
            Container(
              width: 420.0,
              height: 260.0,
              child: _invitedListView(),
              decoration: BoxDecoration(
                  border: Border.all(
                color: Colors.grey,
                width: 2.0,
              )),
            ),
            SizedBox(height: 40.0,),
            Text(
              "Amigos",
              style: TextStyle(fontSize: 35.0),
            ),
            SizedBox(height: 20.0,),
            Container(
              width: 420.0,
              height: 260.0,
              child: _friendsListView(),
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
                    Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => InvitationCheckout()));
                  },
                )
              ],
            )
          ],
        ),
        )
    );
  }

  Widget _buildItem(String item, Animation animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        child: ListTile(
          title: Text(
            item,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  void _insertSingleItem() {
    String newItem = "Planet";
    // Arbitrary location for demonstration purposes
    int insertIndex = 2;
    // Add the item to the data list.
    //_data.insert(insertIndex, newItem);
    // Add the item visually to the AnimatedList.
    //_listKey.currentState.insertItem(insertIndex);
  }

  void _removeSingleItem() {
    int removeIndex = 2;
    // Remove item from data list but keep copy to give to the animation.
    //String removedItem = _data.removeAt(removeIndex);
    // This builder is just for showing the row while it is still
    // animating away. The item is already gone from the data list.
    AnimatedListRemovedItemBuilder builder = (context, animation) {
      //return _buildItem(removedItem, animation);
    };
    // Remove the item visually from the AnimatedList.
    //_listKey.currentState.removeItem(removeIndex, builder);
  }

  Widget _invitedListView() {
    return ListView.separated(
      itemCount: _invitedListSize(),
      itemBuilder: (context, index) {
        var item = invitedList[index];

        return Dismissible(
          key: Key(item),
          onDismissed: (direction) {
            setState(() {
              friendsList.add(item);
              invitedList.removeAt(index);
            });

            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text("$item dismissed")));
          },
          background: Container(color: Colors.red),
          child: ListTile(title: Text("$item")),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget _friendsListView() {
    return ListView.separated(
      itemCount: _friendsListSize(),
      itemBuilder: (context, index) {
        var item = friendsList[index];

        return Dismissible(
          key: Key(item),
          onDismissed: (direction) {
            setState(() {
              invitedList.add(item);
              friendsList.removeAt(index);
            });

            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text("$item dismissed")));
          },
          background: Container(color: Colors.green),
          child: ListTile(title: Text("$item")),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  int _friendsListSize() {
    if (friendsList.isEmpty)
      return 0;
    else
      return friendsList.length;
  }

  int _invitedListSize() {
    if (invitedList.isEmpty)
      return 0;
    else
      return invitedList.length;
  }
}

void addFriendToList() {
  friendsList.add("Nuevo amigo");
}

int invitedListSize() {
  if (invitedList.isEmpty)
    return 0;
  else
    return invitedList.length;
}
