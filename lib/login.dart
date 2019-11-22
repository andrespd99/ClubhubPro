import 'package:clubhub/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:clubhub/RegisterPage.dart';
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
                    image: ExactAssetImage('assets/images/curved.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                child: new Card(
                  color: Colors.grey[100],
                  margin: new EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 250.0, bottom: 80.0),
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
                        new RaisedButton(
                          color: Colors.blue,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          padding: new EdgeInsets.all(16.0),

                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 6,
                              right: 32,
                            ),
                            child: InkWell(
                              onTap: () => _pushPage(context, RegisterPage()),
                              child: Container(
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ), onPressed: () {},
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
     user = await _auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text) as FirebaseUser;
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

/*
class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _password;
  String _email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Text(
                    'Login Information',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                      onSaved: (value) => _email = value,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: "Email Address")),
                  TextFormField(
                      onSaved: (value) => _password = value,
                      obscureText: true,
                      decoration: InputDecoration(labelText: "Password")),
                  SizedBox(height: 20.0),
                  RaisedButton(
                      child: Text("LOGIN"),
                      onPressed: () async {
                        final form = _formKey.currentState;
                        form.save();
                        if (form.validate()) {
                          try {
                            AuthResult result =
                                await Provider.of<AuthService>(context)
                                    .loginUser(
                                        email: _email, password: _password);
                            print(result);
                          } on AuthException catch (error) {
                            // handle the firebase specific error
                            return _buildErrorDialog(context, error.message);
                          } on Exception catch (error) {
                            // gracefully handle anything else that might happen..
                            return _buildErrorDialog(context, error.toString());
                          }
                        }
                      }),
                ],
              ),
            )));
  }

  Future _buildErrorDialog(BuildContext context, _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Error Message'),
          content: Text(_message),
          actions: <Widget>[
            FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }
} hasta aqui estaba bien fino */

/*class _LoginPageState extends State<LoginPage> {
  // Widget blueCircle = new ClipOval(
  //   child: Container(
  //     width: 20.0,
  //     height: 20.0,
  //     decoration: new BoxDecoration(
  //       color: kClubhubBlue400,
  //       // shape: BoxShape.circle,
  //       // image: DecorationImage(
  //       //     fit: BoxFit.fit,
  //       //     image: NetworkImage("https://www.picsum.photos/1500/2000"),
  //       //     colorFilter: new ColorFilter.mode(
  //       //         Colors.black.withOpacity(0.2), BlendMode.dstATop)),
  //     ),
  //   ),
  // );

   bool _isSelected = false;

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            top: -w / 3,
            child: Transform.scale(
              scale: 1.6,
              child: Align(
                child: ClipOval(
                  child: Container(
                    width: w,
                    height: w,
                    decoration: BoxDecoration(
                      color: kClubhubBlueMain,
                      // image: DecorationImage(
                      //     fit: BoxFit.cover,
                      //     image:
                      //         NetworkImage('https://picsum.photos/2000/1200'),
                      //     colorFilter: new ColorFilter.mode(
                      //         Colors.black.withOpacity(0.3),
                      //         BlendMode.dstATop))
                    ),
                  ),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                //child: Image.asset("assets/image_01.png"),
              ),
              Expanded(
                child: Container(),
              ),
              //Image.asset("assets/image_02.png")
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
              child: Column(
                children: <Widget>[
                  // Row(
                  //   children: <Widget>[
                  //     Image.asset(
                  //       "assets/logo.png",
                  //       width: ScreenUtil.getInstance().setWidth(110),
                  //       height: ScreenUtil.getInstance().setHeight(110),
                  //     ),
                  //     Text("LOGO",
                  //         style: TextStyle(
                  //             fontFamily: "Poppins-Bold",
                  //             fontSize: ScreenUtil.getInstance().setSp(46),
                  //             letterSpacing: .6,
                  //             fontWeight: FontWeight.bold))
                  //   ],
                  // ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(180),
                  ),
                  FormCard(),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 12.0,
                          ),
                          // GestureDetector(
                          //   onTap: _radio,
                          //   child: radioButton(_isSelected),
                          // ),
                          // SizedBox(
                          //   width: 8.0,
                          // ),
                          // Text("Recuerdame",
                          //     style: TextStyle(
                          //         fontSize: 12, fontFamily: "Poppins-Medium"))
                        ],
                      ),
                      InkWell(
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(330),
                          height: ScreenUtil.getInstance().setHeight(100),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF17ead9),
                                Color(0xFF6078ea)
                              ]),
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF6078ea).withOpacity(.3),
                                    offset: Offset(0.0, 8.0),
                                    blurRadius: 8.0)
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()),
                                  (Route<dynamic> route) => false,
                                );
                              },
                              child: Center(
                                child: Text("Iniciar Sesion",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins-Bold",
                                        fontSize: 18,
                                        letterSpacing: 1.0)),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     horizontalLine(),
                  //     Text("Social Login",
                  //         style: TextStyle(
                  //             fontSize: 16.0, fontFamily: "Poppins-Medium")),
                  //     horizontalLine()
                  //   ],
                  // ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     SocialIcon(
                  //       colors: [
                  //         Color(0xFF102397),
                  //         Color(0xFF187adf),
                  //         Color(0xFF00eaf8),
                  //       ],
                  //       iconData: CustomIcons.facebook,
                  //       onPressed: () {},
                  //     ),
                  //     SocialIcon(
                  //       colors: [
                  //         Color(0xFFff4f38),
                  //         Color(0xFFff355d),
                  //       ],
                  //       iconData: CustomIcons.googlePlus,
                  //       onPressed: () {},
                  //     ),
                  //     SocialIcon(
                  //       colors: [
                  //         Color(0xFF17ead9),
                  //         Color(0xFF6078ea),
                  //       ],
                  //       iconData: CustomIcons.twitter,
                  //       onPressed: () {},
                  //     ),
                  //     SocialIcon(
                  //       colors: [
                  //         Color(0xFF00c6fb),
                  //         Color(0xFF005bea),
                  //       ],
                  //       iconData: CustomIcons.linkedin,
                  //       onPressed: () {},
                  //     )
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: ScreenUtil.getInstance().setHeight(30),
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     Text(
                  //       "Nuevo usuario? ",
                  //       style: TextStyle(fontFamily: "Poppins-Medium"),
                  //     ),
                  //     InkWell(
                  //       onTap: () {},
                  //       child: Text("Registrate",
                  //           style: TextStyle(
                  //               color: Color(0xFF5d74e3),
                  //               fontFamily: "Poppins-Bold")),
                  //     )
                  //   ],
                  // )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
} */

// child: Column(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: <Widget>[
//     Text(
//       "Inicio de sesión",
//       style: TextStyle(
//         fontSize: 20,
//       ),
//     ),
//     SizedBox(height: 70),
//     TextField(
//       decoration: InputDecoration(
//         filled: false,
//         labelText: "Número de acción",
//       ),
//     ),
//     SizedBox(height: 70),
//     TextField(
//       decoration: InputDecoration(
//         filled: false,
//         labelText: "Contraseña",
//       ),
//       obscureText: true,
//     ),
//     SizedBox(height: 50.0),
//     ButtonBar(
//       alignment: MainAxisAlignment.center,
//       children: <Widget>[
//         RaisedButton(
//           textColor: Colors.white,
//           color: Colors.black,
//           child: Padding(
//             padding:
//                 EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//             child: Text(
//               "Ingresar",
//               style: TextStyle(fontSize: 18.0),
//             ),
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: new BorderRadius.circular(35.0),
//           ),
//           onPressed: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => Home()));
//           },
//         ),
//       ],
//     ),
//   ],
// ),

// // final _usernameController = TextEditingController();
// // final _passwordController = TextEditingController();

// class AccentColorOverride extends StatelessWidget {
//   const AccentColorOverride({Key key, this.color, this.child})
//       : super(key: key);

//   final Color color;
//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       child: child,
//       data: Theme.of(context).copyWith(
//         accentColor: color,
//         brightness: Brightness.dark,
//       ),
//     );
//   }
// }
