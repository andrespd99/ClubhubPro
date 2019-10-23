import 'package:flutter/material.dart';
import 'main.dart';
import 'invitaciones.dart';

class AddFriend extends StatefulWidget {
  AddFriendState createState() => AddFriendState();
  Widget build(BuildContext context) {
    return Container(
    );
  }
}

class AddFriendState extends State<AddFriend> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Agregar amigo",
      )),
      body: Column(
        children: <Widget>[
          MyCustomForm()
        ],
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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(50.0),
      child: Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          //Nombre de invitado
          TextFormField(
            validator: (value) => isEmptyValidator(value),
            decoration: InputDecoration(
              labelText: "Nombre",
              helperText: "*Requerido"
            ),
          ),
          //Apellido de invitado
          TextFormField(
            validator: (value) => isEmptyValidator(value),
            decoration: InputDecoration(
              labelText: "Apellidos",
              helperText: "*Requerido"
            ),
          ),
          //Cedula de Identidad
          TextFormField(
            validator: (value) => isEmptyValidator(value),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Cédula",
              helperText: "*Requerido"
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                  addFriendToList();
                  Navigator.pop(context); 
                }
              },
              child: Text('Agregar'),
            ),
          ),
        ],
      )
    ),
    );
  }
}

String isEmptyValidator(String value){
  if(value.isEmpty){
    return 'Debe llenar este campo';
  }
  return null;
}