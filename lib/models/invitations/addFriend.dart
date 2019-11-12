import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clubhub/models/invitations/AddFriendForm.dart';
import 'package:flutter/material.dart';

class AddFriend extends StatefulWidget {
  AddFriendState createState() => AddFriendState();
}

class AddFriendState extends State<AddFriend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(),
          title: Text(
            "Agregar amigo",
          )),
      body: Column(
        children: <Widget>[AddFriendForm()],
      ),
    );
  }
}
