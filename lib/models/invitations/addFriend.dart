import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clubhub/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class AddFriend extends StatefulWidget {
  AddFriendState createState() => AddFriendState();
  Widget build(BuildContext context) {
    return Container();
  }
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
        children: <Widget>[MyCustomForm()],
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  //Llave global de referencia al form.
  final _formKey = GlobalKey<FormState>();
  //Controladores del form.
  final _nameFieldController = TextEditingController();
  final _lastNameFieldController = TextEditingController();
  final _cidFieldController = TextEditingController();
  final _dateTimeFieldController = TextEditingController();

  @override
  void dispose() {
    this._nameFieldController.dispose();
    this._cidFieldController.dispose();
    this._dateTimeFieldController.dispose();
    super.dispose();
  }

  void _addFriendToList(
      String name, String cid, String birthdate) {
    print('metodo iniciado');
    Firestore.instance.collection('userFriends').add({
      'name': name,
      'cid': cid,
      'birthdate': DateTime.tryParse(birthdate),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(50.0),
      child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              showNameInput(),
              showCidInput(),
              showDateField(),
              showSendButton(),
            ],
          )),
    );
  }

  Widget showNameInput() {
    return TextFormField(
      controller: _nameFieldController,
      validator: (value) => isEmptyValidator(value),
      decoration:
          InputDecoration(labelText: "Nombre", helperText: "* Requerido"),
    );
  }

  Widget showLastNameInput() {
    return TextFormField(
      controller: _lastNameFieldController,
      validator: (value) => isEmptyValidator(value),
      decoration:
          InputDecoration(labelText: "Apellidos", helperText: "* Requerido"),
    );
  }

  Widget showCidInput() {
    return TextFormField(
      controller: _cidFieldController,
      validator: (value) => isEmptyValidator(value),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          //prefixIcon: Icon(Icons.card_membership),
          labelText: "Cédula",
          helperText: "* Requerido"),
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
    );
  }

  Widget showSendButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        onPressed: () {
          AlertDialog(
            content: Text(_dateTimeFieldController.text),
          );
          if (_formKey.currentState.validate()) {
            _addFriendToList(
                _nameFieldController.text,
                _cidFieldController.text,
                _dateTimeFieldController.text);
            Navigator.pop(context);
          }
        },
        child: Text('Agregar'),
      ),
    );
  }

  Widget showDateField() {
    final format = DateFormat("yyyy-MM-dd");
    return Column(children: <Widget>[
      DateTimeField(
          controller: _dateTimeFieldController,
          format: format,
          onShowPicker: (context, currentValue) {
            return showDatePicker(
                context: context,
                firstDate: DateTime.now().subtract(Duration(days: 41975)),
                initialDate: DateTime.now().subtract(Duration(days: 1460)),
                lastDate: DateTime.now().subtract(Duration(days: 1460)));
          },
          decoration: InputDecoration(
            counterText: 'Fecha de nacimiento',
            helperText: '* Requerido',
          )),
    ]);
  }
}

String isEmptyValidator(String value) {
  if (value.isEmpty) {
    return 'Campo requerido';
  }
  return null;
}
