import 'package:flutter/material.dart';
import 'signuppage.dart';
import 'photopage.dart';
import 'User.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  // final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is disposed.
  //   _emailcontroller.dispose();
  //   _passwordcontroller.dispose();
  //   super.dispose();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _user = createUser(_emailcontroller.text, _passwordcontroller.text);
  // }

//-----------------------------------------
  @override
  Widget build(BuildContext context) {
    // email field
    final emailField = TextField(
      obscureText: false,
      controller: _emailcontroller,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    // password field
    final passwordField = TextField(
      obscureText: true,
      controller: _passwordcontroller,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    // log in button
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          setState(() {
            signinUser(_emailcontroller.text, _passwordcontroller.text)
                .then((response) {
              if (response.statusCode == 200) {
                print(response.statusCode);
                navigateToSubPage(context);
              }
              else
                popUp(context);
              // print(response.statusCode);
            }).catchError((error) {
              print('error : $error');
            });
          });
        },
        child: Text("Log in",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    // sign up button
    final signupButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          print('Sign up');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpPage()),
          );
        },
        child: Text("Sign up",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    // return MaterialApp(
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Wall'),
        backgroundColor: Color(0xff01A0C7),
      ),
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // email - - - - - - - - - - - - - - - -
              SizedBox(height: 45.0),
              emailField,
              // password - - - - - - - - - - - - - - -
              SizedBox(height: 25.0),
              passwordField,
              // login button - - - - - - - - - - - - -
              SizedBox(height: 35.0),
              loginButon,
              // sign up button - - - - - - - - - - - -
              SizedBox(height: 35.0),
              signupButon,
            ],
          )),
    );
  }
}

Future navigateToSubPage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => PhotoPage()));
}

Future popUp(context) async {
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: Text("invalid"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}