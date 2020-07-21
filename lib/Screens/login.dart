import 'package:chatrooms/Screens/singup.dart';
import 'package:chatrooms/Services/auth.dart';
import 'package:chatrooms/main.dart';
import 'package:chatrooms/providers/ModelHud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../Widgets/CustomTextField.dart';

class LoginScreen extends StatelessWidget {
  Auth _auth = Auth();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String email;
    String pass;
    return ModalProgressHUD(
      inAsyncCall: Provider.of<ModelHud>(context).isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Form(
          key: _globalKey,
          child: Column(
            children: <Widget>[
              CustomTextField(
                icon: Icons.email,
                hint: "Enter your email",
                onClick: (value) {
                  email = value;
                },
              ),
              CustomTextField(
                icon: Icons.opacity,
                hint: "Enter your password",
                onClick: (value) {
                  pass = value;
                },
              ),
              Builder(
                builder: (BuildContext context) {
                  return FlatButton(
                    onPressed: () async {
                      final modelhud =
                          Provider.of<ModelHud>(context, listen: false);
                      modelhud.changeisLoading(true);
                      Provider.of<ModelHud>(context, listen: false)
                          .changeisLoading(true);
                      if (_globalKey.currentState.validate()) {
                        _globalKey.currentState.save();
                        try {
                          final authResult =
                              await _auth.signIn(email.trim(), pass.trim());
                          modelhud.changeisLoading(false);
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return app(authResult.user.email);
                          }));
                        } on PlatformException catch (e) {
                          modelhud.changeisLoading(false);
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(e.message),
                          ));
                        }
                      }
                    },
                    child: Text("login"),
                  );
                },
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return SignupScreen();
                  }));
                },
                child: Text("dont have account? , Signup"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
