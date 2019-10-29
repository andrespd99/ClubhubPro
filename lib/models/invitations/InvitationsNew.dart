import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Invitations extends StatefulWidget {
  final String friendsListId;

  Invitations({this.friendsListId});

  @override
  _InvitationsState createState() => _InvitationsState();
}

class _InvitationsState extends State<Invitations> {



  @override
  Widget build(BuildContext context) {

  // Future<DocumentSnapshot> map = Firestore.instance.collection('userFriends').document(widget.friendsListId).snapshots().elementAt(index);
  
    return Container(
      // child: ListView.builder(
        // itemCount: ,
        // itemBuilder: ,
      );
    
  }
}

class Record {
 final String friendName;
 final String cid;
 final DocumentReference reference;

 Record.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['name'] != null),
       assert(map['cid'] != null),
       friendName = map['name'],
       cid = map['cid'];

 Record.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

}