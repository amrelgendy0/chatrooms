import 'package:chatrooms/Services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Signupscreen extends StatelessWidget {
  Auth _auth = Auth();
  @override
  Widget build(BuildContext context) {
    String email;
    String pass;
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup"),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            onChanged: (value) {
              email = value;
            },
          ),
          TextField(
            onChanged: (value) {
              pass = value;
            },
          ),FlatButton(
            onPressed: () {
              _auth.signUp(email, pass);
            },
            child: Text("Login"),
          )
        ],
      ),
    );
  }
}
