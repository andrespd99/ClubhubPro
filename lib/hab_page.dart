import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/transformers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

TextStyle bold24Roboto =
    TextStyle(color: Colors.black, fontSize: 20.0, height: 2);

class ListasHabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection('bedrooms').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                return new Card(
                  // Los hijos dentro de card en columnas, debajo de otro
                  child: new InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailScreen(snapshot: snapshot, index: index),
                        ),
                      );
                    },
                    child: new Column(children: <Widget>[
                      // Agregamos una imagen consumida desde internet
                      Text(
                          snapshot.data.documents[index].data.values
                              .elementAt(3)
                              .toString(),
                          softWrap: true,
                          style: bold24Roboto),
                      new Container(
                          child: CarouselSlider(
                        height: 300.0,
                        items: [0, 1, 2].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 4.0),
                                child: StreamBuilder(
                                    stream: Firestore.instance
                                        .collection('bedrooms')
                                        .document(snapshot
                                            .data.documents[index].documentID)
                                        .collection('images')
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot>
                                            snapshot2) {
                                      if (!snapshot2.hasData)
                                        return CircularProgressIndicator();
                                      return new CachedNetworkImage(
                                        imageUrl: snapshot2
                                            .data.documents[0].data.values
                                            .elementAt(i + 1)
                                            .toString(),
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        height: 300,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      );
                                    }),
                              );
                            },
                          );
                        }).toList(),
                      )),

                      // Agregamos un contenedor para el texto

                      new Container(
                        padding:
                            const EdgeInsets.all(10.0), // Un padding para todo
                        child: Text(
                          snapshot.data.documents[index].data.values
                              .elementAt(0)
                              .toString(),
                          softWrap: true,
                        ),
                      ),

                      new Padding(
                          // Esta seccion sera para los botones de acciones
                          padding: new EdgeInsets.all(
                              7.0), // Un padding general entre cada elemento
                          child: new Row(
                            // mainAxisAlignment permite alinear el contenido dentro de Row
                            // en este caso le digo que use spaceBetwee, esto hara que
                            // cualquier espacio horizontal que no se haya asignado dentro de children
                            // se divida de manera uniforme y se coloca entre los elementos secundarios.
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // Agregamos los botones de tipo Flat, un icono, un texto y un evento
                              new FlatButton.icon(
                                // Un icono puede recibir muchos atributos, aqui solo usaremos icono, tamaño y color
                                icon: const Icon(Icons.attach_money,
                                    size: 26.0, color: Colors.redAccent),

                                // Esto mostrara 'Me encanta' por la terminal
                                onPressed: () {},
                                label: Text(snapshot
                                        .data.documents[index].data.values
                                        .elementAt(2)
                                        .toString() +
                                    ' día'),
                              )
                            ],
                          ))
                    ]),
                  ),
                );
              });
        });
  }
}

class DetailScreen extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final int index;
  DetailScreen({Key key, @required this.snapshot, @required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RESERVAR'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: new Column(children: <Widget>[
          // Agregamos una imagen consumida desde internet
          Text(
              snapshot.data.documents[index].data.values
                  .elementAt(3)
                  .toString(),
              softWrap: true,
              style: bold24Roboto),
          new Container(
              child: CarouselSlider(
            height: 300.0,
            items: [0, 1, 2].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: StreamBuilder(
                        stream: Firestore.instance
                            .collection('bedrooms')
                            .document(snapshot.data.documents[index].documentID)
                            .collection('images')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot2) {
                          if (!snapshot2.hasData)
                            return CircularProgressIndicator();
                          return new CachedNetworkImage(
                            imageUrl: snapshot2.data.documents[0].data.values
                                .elementAt(i + 1)
                                .toString(),
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                          );
                        }),
                  );
                },
              );
            }).toList(),
          )),

          // Agregamos un contenedor para el texto

          new Container(
            padding: const EdgeInsets.all(10.0), // Un padding para todo
            child: Text(
              snapshot.data.documents[index].data.values
                  .elementAt(0)
                  .toString(),
              softWrap: true,
            ),
          ),

          new Padding(
              // Esta seccion sera para los botones de acciones
              padding: new EdgeInsets.all(
                  7.0), // Un padding general entre cada elemento
              child: new Row(
                // mainAxisAlignment permite alinear el contenido dentro de Row
                // en este caso le digo que use spaceBetwee, esto hara que
                // cualquier espacio horizontal que no se haya asignado dentro de children
                // se divida de manera uniforme y se coloca entre los elementos secundarios.
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Agregamos los botones de tipo Flat, un icono, un texto y un evento
                  new FlatButton.icon(
                    // Un icono puede recibir muchos atributos, aqui solo usaremos icono, tamaño y color
                    icon: const Icon(Icons.attach_money,
                        size: 26.0, color: Colors.redAccent),

                    // Esto mostrara 'Me encanta' por la terminal
                    onPressed: () {},
                    label: Text(snapshot.data.documents[index].data.values
                            .elementAt(2)
                            .toString() +
                        ' día'),
                  ),
                  new FlatButton.icon(
                    // Un icono puede recibir muchos atributos, aqui solo usaremos icono, tamaño y color
                    icon: const Icon(Icons.photo_size_select_large,
                        size: 26.0, color: Colors.redAccent),

                    // Esto mostrara 'Me encanta' por la terminal
                    onPressed: () {},
                    label: Text(snapshot.data.documents[index].data.values
                            .elementAt(1)
                            .toString() +
                        ' area'),
                  ),
                  new FlatButton.icon(
                    // Un icono puede recibir muchos atributos, aqui solo usaremos icono, tamaño y color
                    icon: const Icon(Icons.check_box_outline_blank,
                        size: 26.0, color: Colors.redAccent),

                    // Esto mostrara 'Me encanta' por la terminal
                    onPressed: () {},
                    label: Text('2' +
                        ' camas'),
                  )
                ],
              )),

          new Padding(
              // Esta seccion sera para los botones de acciones
              padding: new EdgeInsets.all(
                  7.0), // Un padding general entre cada elemento
              child: new Row(
                // mainAxisAlignment permite alinear el contenido dentro de Row
                // en este caso le digo que use spaceBetwee, esto hara que
                // cualquier espacio horizontal que no se haya asignado dentro de children
                // se divida de manera uniforme y se coloca entre los elementos secundarios.
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Agregamos los botones de tipo Flat, un icono, un texto y un evento
                  
                  new FlatButton.icon(
                    // Un icono puede recibir muchos atributos, aqui solo usaremos icono, tamaño y color
                    icon: const Icon(Icons.wifi,
                        size: 26.0, color: Colors.redAccent),

                    // Esto mostrara 'Me encanta' por la terminal
                    onPressed: () {},
                    label: Text('Acceso a Internet'),
                  ),
                  new FlatButton.icon(
                    // Un icono puede recibir muchos atributos, aqui solo usaremos icono, tamaño y color
                    icon: const Icon(Icons.control_point_duplicate,
                        size: 26.0, color: Colors.redAccent),

                    // Esto mostrara 'Me encanta' por la terminal
                    onPressed: () {},
                    label: Text('Seguridad las 24 horas'),
                  )
                ],
              )),
         new Padding(
              // Esta seccion sera para los botones de acciones
              padding: new EdgeInsets.all(
                  7.0), // Un padding general entre cada elemento
              child: new Row(
                // mainAxisAlignment permite alinear el contenido dentro de Row
                // en este caso le digo que use spaceBetwee, esto hara que
                // cualquier espacio horizontal que no se haya asignado dentro de children
                // se divida de manera uniforme y se coloca entre los elementos secundarios.
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Agregamos los botones de tipo Flat, un icono, un texto y un evento
                  new FlatButton.icon(
                    // Un icono puede recibir muchos atributos, aqui solo usaremos icono, tamaño y color
                    icon: const Icon(Icons.cloud,
                        size: 26.0, color: Colors.redAccent),

                    // Esto mostrara 'Me encanta' por la terminal
                    onPressed: () {},
                    label: Text('Aire acondicionado'),
                  ),

                  new FlatButton.icon(
                    // Un icono puede recibir muchos atributos, aqui solo usaremos icono, tamaño y color
                    icon: const Icon(Icons.room_service,
                        size: 26.0, color: Colors.redAccent),

                    // Esto mostrara 'Me encanta' por la terminal
                    onPressed: () {},
                    label: Text('Servicio a la habitación'),
                  ),
                  
                ],
              )),
              new Padding(
              // Esta seccion sera para los botones de acciones
              padding: new EdgeInsets.all(
                  7.0), // Un padding general entre cada elemento
              child: new Row(
                // mainAxisAlignment permite alinear el contenido dentro de Row
                // en este caso le digo que use spaceBetwee, esto hara que
                // cualquier espacio horizontal que no se haya asignado dentro de children
                // se divida de manera uniforme y se coloca entre los elementos secundarios.
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Agregamos los botones de tipo Flat, un icono, un texto y un evento
                  new FlatButton.icon(
                    // Un icono puede recibir muchos atributos, aqui solo usaremos icono, tamaño y color
                    icon: const Icon(Icons.panorama_wide_angle,
                        size: 26.0, color: Colors.redAccent),

                    // Esto mostrara 'Me encanta' por la terminal
                    onPressed: () {},
                    label: Text('Balcón'),
                  ),

                  new FlatButton.icon(
                    // Un icono puede recibir muchos atributos, aqui solo usaremos icono, tamaño y color
                    icon: const Icon(Icons.tv,
                        size: 26.0, color: Colors.redAccent),

                    // Esto mostrara 'Me encanta' por la terminal
                    onPressed: () {},
                    label: Text('Satélite/TV por cable'),
                  ),
                  
                ],
              )),
                  
        ]),
      ),
      
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Reserva exitosa'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Habitación reservada por 15 minutos.'),
              Text('Dirigase al carrito de compras para terminar el proceso.'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Aceptar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
        },
        child: Icon(Icons.add_shopping_cart),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

}
