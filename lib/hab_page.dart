import 'package:flutter/material.dart';
import 'hab_data.dart';

class ListasHabPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  ContactList(klistas);
    
  }

}

class ContactList extends StatelessWidget {

  final List<ListaHab> _contacts;

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

  _ContactListItem(ListaHab contact) :
    super(
      title : Text(contact.title + '  |  '+ contact.precio +' BsS'),
      subtitle: Text(contact.details),
      leading: CircleAvatar(
        child: Icon(Icons.photo)
      )
    );

}