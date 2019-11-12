import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clubhub/Home.dart';
import 'package:clubhub/assets/colors.dart';
import 'package:clubhub/models/invitations/FriendInvited.dart';
import 'package:clubhub/models/invitations/InvitationFinal.dart';
import 'package:flutter/material.dart';
import 'package:clubhub/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvitationCheckout extends StatefulWidget {
  List<FriendInvited> invitedFriends;

  InvitationCheckout({this.invitedFriends});

  @override
  State<StatefulWidget> createState() => InvitationCheckoutState();
  Widget build(BuildContext context) {
    return Container();
  }
}

class InvitationCheckoutState extends State<InvitationCheckout> {
  static final invitationPrice = 56000.00;
  var total;

  @override
  void initState() {
    super.initState();
    this.total = widget.invitedFriends.length * invitationPrice;
  }

  @override
  void dispose() {
    widget.invitedFriends.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Invitar')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Text("Factura de invitaciones", style: TextStyle(fontSize: 30.0)),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  width: 420.0,
                  height: 260.0,
                  child: showInvitedList(),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  )),
                ),
              ),
              SizedBox(height: 20.0),
              Column(
                children: <Widget>[
                  Text("Total: $total Bs.S", style: TextStyle(fontSize: 20.0)),
                  Text("Precio por invitacion: $invitationPrice",
                      style: TextStyle(fontSize: 15.0),
                      textAlign: TextAlign.right),
                ],
              ),
              SizedBox(height: 30.0),
              showCheckoutButton(),
            ],
          ),
        ),
      ),
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
            itemCount: widget.invitedFriends.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: _buildInvitedTile(
                    context, widget.invitedFriends.elementAt(index), index),
              );
            },
          ),
        ));
  }

  Widget _buildInvitedTile(
      BuildContext context, FriendInvited friend, int index) {
    return Row(
      children: <Widget>[
        // Container(
        //   width: 28.0,
        //   height: 28.0,
        //   child: showRemoveFromInviteListButton(friend.cid),
        // ),
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

  Widget showCheckoutButton() {
    return RaisedButton(
      child: Text('Finalizar'),
      onPressed: () {
        if (widget.invitedFriends.isNotEmpty) {
          DocumentReference dr =
              Firestore.instance.collection('inviteHistory').document();
          dr.setData({
            'date': DateTime.now(),
            'total': total,
          });
          for (var i = 0; i < widget.invitedFriends.length; i++) {
            dr.collection('friendInvited').add({
              'name': widget.invitedFriends.elementAt(i).name,
              'cid': widget.invitedFriends.elementAt(i).cid,
            });
          }
        }
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Home()),
          (Route<dynamic> route) => false,
        );
      },
    );
  }
}
