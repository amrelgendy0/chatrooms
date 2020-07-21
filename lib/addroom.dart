import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Addroom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String name;
    return AlertDialog(
      actions: <Widget>[
        FlatButton(
          child: Text("Create"),
          onPressed: () {
            FirebaseDatabase.instance.reference().child("Rooms").update({
              "${Random().nextInt(9999999999)}": {"name": "$name"}
            });
          },
        )
      ],
      title: Text("Enter Room name"),
      content: TextField(
        onChanged: (vaa) {
          name = vaa;
        },
      ),
    );
  }
}