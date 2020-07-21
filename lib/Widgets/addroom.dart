import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';
class Addroom extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String name;
    return AlertDialog(
      actions: <Widget>[
        FlatButton(
          child: Text("Create"),
          onPressed: () {
            if (_globalKey.currentState.validate()) {
              FirebaseDatabase.instance.reference().child("Rooms").update({
                "${Uuid().v5("$name", name)}": {
                  "name": "$name",
                  "users": {"as": "as"},
                }
              });
              Firestore.instance.collection("$name").add({});
              Navigator.of(context).pop();
            }
          },
        )
      ],
      title: Text("Enter Room name"),
      content: Form(
        key: _globalKey,
        child: TextFormField(
          validator: (value) {
            if (value.contains("@")) {
              return 'RoomName cant contains @';
            }
            if (value.trim() == '') {
              return 'RoomName cant be empty';
            }
          },
          onChanged: (vaa) {
            name = vaa;
          },
        ),
      ),
    );
  }
}
