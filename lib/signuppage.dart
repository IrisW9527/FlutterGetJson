import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'User.dart';

// after sign up going back to login page for logging in

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}


class _SignUpPageState extends State<SignUpPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final usernameField = TextField(
      obscureText: false,
      controller: _usernamecontroller,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Username",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
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
    final continueButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          setState(() {
            createUser(_usernamecontroller.text,_emailcontroller.text, _passwordcontroller.text)
                .then((response) {
              if (response.statusCode == 201)
                // print(response.body);
                navigateToLoginPage(context);
              else
                popUpReg(context);
                print(response.statusCode);
            }).catchError((error) {
              print('error : $error');
            });
          });
        },
        child: Text("Continue",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    final backButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
          );
        },
        child: Text("Back to Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    "Create an account",
                    style: TextStyle(fontSize: 30.0),
                  ),
                ),
                SizedBox(height: 50.0),
                usernameField,
                SizedBox(height: 40.0),
                emailField,
                SizedBox(height: 35.0),
                passwordField,
                SizedBox(
                  height: 40.0,
                ),
                continueButon,
                SizedBox(
                  height: 40.0,
                ),
                backButon,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future navigateToLoginPage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
}

Future popUpReg(context) async {
  Widget okButton = FlatButton(
    child: Text("ok"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: Text("Try it again"),
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