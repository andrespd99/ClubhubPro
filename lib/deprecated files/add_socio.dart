import 'package:flutter/material.dart';

class Data {
  final String accion;
 final String nombre;
 final String ci;
 final String direccion;
  final String email;
  
const Data({this.accion, this.nombre, this.ci,this.direccion,this.email});
}

class Contact {
  final String fullName;
  final String email;

  const Contact({this.fullName, this.email});
}
  

class AddSocio extends StatefulWidget {
  AddSocioState createState()=> AddSocioState();  
  }

  class AddSocioState extends State<AddSocio> {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("REGISTRO DE SOCIOS"),
      ),
      body: Center(
        child:Container(
        margin: EdgeInsets.all(50.0),
        child: 
        Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:       
         <Widget>[
           Padding(
             padding: const EdgeInsets.all(10.0),
          
           ),
          Text('Numero de accion'),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            
          ),
          Text('Nombre y apellido'),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            
          ),
          Text('Numero de cedula'),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            
          ),
          Text('Dirección'),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            
          ),
          Text('Email'),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
               
            Navigator.pushNamed(context, '/listasociospage');
          },
              child: Text('Registrar Socio'),
            ),
          ),
        ],
      ),
      ),
    )
    );
    
  }
}
