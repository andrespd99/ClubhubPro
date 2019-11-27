import 'package:clubhub/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:clubhub/RegisterPage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
//import 'package:logincloud/googlepage.dart';
//import 'package:logincloud/page.dart';
//import 'package:logincloud/registerpage.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth',
      home: LoginPage(title: 'Firebase Auth'),
    );
  }
}

class LoginPage extends StatefulWidget {
  final String title;

  LoginPage({Key key, this.title}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FirebaseUser get currentUser => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false, //evitar error bottom overflowed
      body: Form(
        key: _formKey,
        //autovalidate: _autovalidate,
        child: Container(
          //padding: EdgeInsets.all(15.0),
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage('lib/assets/images/curved2.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                child: new Card(
                  color: Colors.white70,
                  margin: new EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 320.0, bottom: 200.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  elevation: 8.0,
                  child: new Padding(
                    padding: new EdgeInsets.all(25.0),
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          child: new TextFormField(
                            maxLines: 1,
                            controller: _emailController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            decoration: new InputDecoration(
                                labelText: 'Email', icon: Icon(Icons.email)),
                            onFieldSubmitted: (value) {
                              //FocusScope.of(context).requestFocus(_phoneFocusNode);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Type your name';
                              }
                            },
                          ),
                        ),
                        new Container(
                          child: new TextFormField(
                            maxLines: 1,
                            controller: _passwordController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            decoration: new InputDecoration(
                              labelText: 'Password',
                              icon: Icon(
                                Icons.vpn_key,
                                color: Colors.black,
                              ),
                            ),
                            onFieldSubmitted: (value) {
                              //FocusScope.of(context).requestFocus(_phoneFocusNode);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Type your password';
                              }
                            },
                          ),
                        ),
                        new Padding(padding: new EdgeInsets.only(top: 30.0)),
                        new RaisedButton(
                          color: Colors.blue,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          padding: new EdgeInsets.all(16.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text(
                                'Login',
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          onPressed: () {
                            signInWithEmail();
                          },
                        ),
                        Divider(),
                        new FlatButton(
                          color: Colors.transparent,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(50.0)),
                          padding: new EdgeInsets.all(16.0),

                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 6,
                              right: 18,
                            ),
                            child: InkWell(
                              
                              child: Container(
                                child: Text(
                                  '¿No tienes cuenta?',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    
                                  ),
                                ),
                              ),
                            ),
                          ), onPressed: () {
                            Alert(context: context, desc: "Envia un correo a administración@club.com junto con tus datos, incluyendo número de acción, en la brevedad posible se te será asignada una cuenta", title: "AVISO").show();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<FirebaseUser> signInWithEmail() async {

    // marked async
    FirebaseUser user;
    try {
     user = (await _auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text)).user;
    } catch (e) {
      print(e.toString());
    } finally {
      if (user != null) {
        // sign in successful!
        _pushPage(context, Home(this.currentUser));
      } else {
        // sign in unsuccessful
        print('sign in Not');
        // ex: prompt the user to try again
      }
    }
  }
}

void _pushPage(BuildContext context, Widget page) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => page),
  );
}

