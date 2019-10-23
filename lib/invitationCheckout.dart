import 'package:flutter/material.dart';
import 'package:clubhub/invitaciones.dart';
import 'package:clubhub/main.dart';

class InvitationCheckout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InvitationCheckoutState();
  Widget build(BuildContext context) {
    return Container();
  }
}

class InvitationCheckoutState extends State<InvitationCheckout> {
  static final invitationPrice = 56000.00;
  var total = invitedList.length * invitationPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Text("Factura de invitaciones",
                  style: TextStyle(fontSize: 30.0)),
              SizedBox(height: 20.0),
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
              RaisedButton(
                child: Text('Finalizar'),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
                  emptyInviteList();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _invitedListView() {
    return ListView.separated(
      itemCount: invitedListSize(),
      itemBuilder: (context, index) {
        var item = invitedList[index];

        return ListTile(title: Text("$item"));
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  void emptyInviteList() {
    /* var x;

    for(int i = 0; i < invitedList.length; i++){
      x = invitedList[i];
      friendsList.add(x);
      invitedList.remove(x);
    } */
  }
}
