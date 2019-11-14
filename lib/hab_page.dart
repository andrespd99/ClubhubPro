import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clubhub/historial_Reservaciones.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flushbar/flushbar.dart';

var finalDate;
var initialDate;

var finalDateTime;
var initialDateTime;

TextStyle bold24Roboto =
    TextStyle(color: Colors.blueAccent, fontSize: 20.0, height: 2);

String _dateInitial = "Not set";
String _dateFinal = "Not set";
DateTime _dateInitialTime = null;
DateTime _dateFinalTime = null;
String _error = '';
String _habTitle = "";
double _habPrice = 0;
var _instance;
var detailsContext;
var _colorDateInicial = Colors.white;
var _colorDateFinal = Colors.white;

class Compra {
  String id;
  double price;
  String name;

  Compra({this.id, this.price, this.name});
}

class DateTimePicker extends StatefulWidget {
  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListasHabPage(),
    );
  }
}

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
                return SingleChildScrollView(
                  child: new Card(
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
                          padding: const EdgeInsets.all(
                              10.0), // Un padding para todo
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
      body: SingleChildScrollView(
        child: Padding(
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
                              .document(
                                  snapshot.data.documents[index].documentID)
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
                      label: Text('2' + ' camas'),
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
                        label: Text(
                          'Acceso a Internet',
                          style: TextStyle(fontSize: ScreenUtil().setSp(20)),
                        )),
                    new FlatButton.icon(
                      // Un icono puede recibir muchos atributos, aqui solo usaremos icono, tamaño y color
                      icon: const Icon(Icons.control_point_duplicate,
                          size: 26.0, color: Colors.redAccent),

                      // Esto mostrara 'Me encanta' por la terminal
                      onPressed: () {},
                      label: Text(
                        'Seguridad las 24 horas',
                        style: TextStyle(fontSize: ScreenUtil().setSp(20)),
                      ),
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
                      label: Text('Aire acondicionado',
                          style: TextStyle(fontSize: ScreenUtil().setSp(20))),
                    ),

                    new FlatButton.icon(
                      // Un icono puede recibir muchos atributos, aqui solo usaremos icono, tamaño y color
                      icon: const Icon(Icons.room_service,
                          size: 26.0, color: Colors.redAccent),

                      // Esto mostrara 'Me encanta' por la terminal
                      onPressed: () {},
                      label: Text('Servicio a la habitación',
                          style: TextStyle(fontSize: ScreenUtil().setSp(20))),
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
                      label: Text('Balcón',
                          style: TextStyle(fontSize: ScreenUtil().setSp(20))),
                    ),

                    new FlatButton.icon(
                      // Un icono puede recibir muchos atributos, aqui solo usaremos icono, tamaño y color
                      icon: const Icon(Icons.tv,
                          size: 26.0, color: Colors.redAccent),

                      // Esto mostrara 'Me encanta' por la terminal
                      onPressed: () {},
                      label: Text('Satélite/TV por cable',
                          style: TextStyle(fontSize: ScreenUtil().setSp(20))),
                    ),
                  ],
                )),
          ]),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          detailsContext = context;
          _habTitle = snapshot.data.documents[index].data.values
              .elementAt(3)
              .toString();

          _habPrice = snapshot.data.documents[index].data.values.elementAt(2);

          _instance = Firestore.instance;

          showDialog(
              context: context,
              builder: (_) {
                return MyDialog();
              });
        },
        child: Icon(Icons.add_shopping_cart),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  Color _c = Colors.redAccent;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Container(
          height: MediaQuery.of(context).size.height / 2.3,
          width: MediaQuery.of(context).size.width / 1.5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _habTitle,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                  Text(
                    "Días a reservar :   ",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        height: 6),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    elevation: 4.0,
                    onPressed: () {
                      DatePicker.showDatePicker(context,
                          theme: DatePickerTheme(
                            containerHeight: 210.0,
                          ),
                          showTitleActions: true,
                          minTime: DateTime.now(),
                          maxTime: DateTime(DateTime.now().year + 1, 12, 31),
                          onChanged: (date) {
                        _dateInitialTime = date;
                      }, onConfirm: (date) {
                        _dateInitialTime = date;
                        _dateInitial =
                            '${date.year} - ${date.month} - ${date.day}';
                        setState(() {});

                        _error = '';
                        _colorDateInicial = Colors.white;
                        _colorDateFinal = Colors.white;
                        _colorDateInicial = Colors.white;
                        setState(() {});
                      }, currentTime: DateTime.now(), locale: LocaleType.es);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                " Desde:  ",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.date_range,
                                      size: 18.0,
                                      color: Colors.blueAccent,
                                    ),
                                    Text(
                                      " $_dateInitial",
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Text(
                            "  edit",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                    color: _colorDateInicial,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    elevation: 4.0,
                    onPressed: () {
                      if (_dateInitialTime == null) {
                        _error = 'Seleccione una fecha inicial';
                        _colorDateFinal = Colors.red[100];
                        setState(() {});
                      } else {
                        DatePicker.showDatePicker(context,
                            theme: DatePickerTheme(
                              containerHeight: 210.0,
                            ),
                            showTitleActions: true,
                            minTime: DateTime(
                                _dateInitialTime.year,
                                _dateInitialTime.month,
                                _dateInitialTime.day + 1),
                            maxTime: DateTime(
                                _dateInitialTime.year,
                                _dateInitialTime.month,
                                _dateInitialTime.day + 5), onChanged: (date) {
                          _dateFinalTime = date;
                        }, onConfirm: (date) {
                          _dateFinalTime = date;
                          _dateFinal =
                              '${date.year} - ${date.month} - ${date.day}';
                          setState(() {});

                          if (_dateInitialTime != null ||
                              (_dateInitialTime.microsecondsSinceEpoch <
                                  _dateFinalTime.microsecondsSinceEpoch)) {
                            _error = '';
                            _colorDateInicial = Colors.white;
                            _colorDateFinal = Colors.white;
                            _colorDateFinal = Colors.white;
                            setState(() {});
                          }
                        }, currentTime: DateTime.now(), locale: LocaleType.es);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                "Hasta:  ",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.date_range,
                                      size: 18.0,
                                      color: Colors.blueAccent,
                                    ),
                                    Text(
                                      " $_dateFinal ",
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Text(
                            "  edit",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                    color: _colorDateFinal,
                  ),
                  Text(
                    _error,
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        height: 6),
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          RaisedButton(
            onPressed: () {
              _dateInitial = "Not set";
              _dateFinal = "Not set";
              _dateInitialTime = null;
              _dateFinalTime = null;
              _error = '';
              _colorDateInicial = Colors.white;
              _colorDateFinal = Colors.white;

              Navigator.pop(context);
            },
            child: Text(
              "Volver",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          RaisedButton(
            onPressed: () {
              if (_dateFinalTime == null || _dateInitialTime == null) {
                _error = 'Debe completar todos los campos.';
                setState(() {});
              } else {
                
                  _instance.collection('historialReservaciones').add({
                    'socio': 'Jonh Doe',
                    'id_socio': 'JD12345',
                    'name': _habTitle,
                    'price': _habPrice,
                    'initialdate': _dateInitialTime,
                    'finaldate': _dateFinalTime
                  });

                  Navigator.pop(context);
                  _dateInitial = "Not set";
                  _dateFinal = "Not set";
                  _dateInitialTime = null;
                  _dateFinalTime = null;
                  _error = '';
                  _colorDateFinal = Colors.white;
                  _colorDateInicial = Colors.white;

                  Flushbar(
                    title: "RESERVA EXITOSA!",
                    message: " Puede verla añadida a su historial ",
                    duration: Duration(seconds: 3),
                  )..show(context);
                 
                 }
            },
            child: Text(
              "Reservar",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ]);
  }
}
