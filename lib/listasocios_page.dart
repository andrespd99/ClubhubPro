import 'package:flutter/material.dart';
import 'listasocios_data.dart';

class ListasPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("LISTADO DE SOCIOS"),
        ),
        body: ContactList(klistas)
      );
  }

}

class ContactList extends StatelessWidget {

  final List<Lista> _contacts;

  ContactList(this._contacts);

  @override
  Widget build(BuildContext context) {
    return ListView(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          children: _buildContactList()
        );
  }

  List<_ContactListItem> _buildContactList() {
    return _contacts.map((contact) => _ContactListItem(contact))
                    .toList();
  }

}

class _ContactListItem extends ListTile {

  _ContactListItem(Lista contact) :
    super(
      title : Text(contact.fullName),
      subtitle: Text(contact.email),
      leading: CircleAvatar(
        child: Text(contact.fullName[0])
      )
    );

}