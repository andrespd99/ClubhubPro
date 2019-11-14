import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Firestore instance = Firestore.instance;
String collectionName = 'historialReservaciones';

class HistorialReservaciones extends StatefulWidget {
  HistorialReservacionesState createState() => HistorialReservacionesState();
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
    );
  }
}

class HistorialReservacionesState extends State<HistorialReservaciones> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Historial'),
        ),
        body: StreamBuilder(
            stream: instance.collection(collectionName).snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                        color: Colors.black38,
                      ),
                  
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SingleChildScrollView(
                      child: ListTile(
                        title: Text(
                          snapshot.data.documents[index].data.values
                                  .elementAt(0)
                                  .toString() +
                              ' amount:  ' +
                              snapshot.data.documents[index].data.values
                                  .elementAt(2)
                                  .toString(),
                                  style: TextStyle(color: Colors.black),
                        ),

                        subtitle: Text(
                          'Desde:  ' +
                              getDate(snapshot.data.documents[index].data.values
                                  .elementAt(3)) +
                              '     Hasta:  ' +
                              getDate(snapshot.data.documents[index].data.values
                                  .elementAt(4)),
                        style: TextStyle(color: Colors.black),),
                        leading: Icon(
                          Icons.new_releases,
                          color: Colors.red[300],
                          size: 25,
                        ),
                        contentPadding: EdgeInsets.all(8.0),
                        onTap: () {
                          final snackBar = SnackBar(
                              content: Text(
                                  'Dirigase al hotel para pagar su reserva!'));

                          Scaffold.of(context).showSnackBar(snackBar);
                        },
                      ),
                    );
                  });
            }));
  }

  getDate(Timestamp date) {
    return date.toDate().year.toString() +
        '-' +
        date.toDate().month.toString() +
        '-' +
        date.toDate().day.toString();
  }
}
