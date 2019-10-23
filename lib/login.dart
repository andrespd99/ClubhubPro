import 'package:clubhub/colors.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget blueCircle = new Transform.scale(
    scale: 3.4,
    child: Container(
      transform: Matrix4.translationValues(0.0, -250.0, 0.0),
      width: 30.0,
      height: 30.0,
      decoration: new BoxDecoration(
        color: kClubhubBlue400,
        shape: BoxShape.circle,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand, //revisar esta propiedad
        children: <Widget>[
          blueCircle,
          Padding(
              padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Inicio de sesión", 
                    style: TextStyle(
                      fontSize: 20,
                    ), 
                  ),
                  SizedBox(height: 70),
                  TextField(
                    decoration: InputDecoration(
                      filled: false,
                      labelText: "Número de acción",
                    ),
                  ),
                  SizedBox(height: 70),
                  TextField(
                    decoration: InputDecoration(
                      filled: false,
                      labelText: "Contraseña",
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 50.0),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        textColor: Colors.white,
                        color: Colors.black,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                          child: Text("Ingresar", style: TextStyle(fontSize: 18.0),),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(35.0),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

final _usernameController = TextEditingController();
final _passwordController = TextEditingController();

class AccentColorOverride extends StatelessWidget {
  const AccentColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(
        accentColor: color,
        brightness: Brightness.dark,
      ),
    );
  }
}
