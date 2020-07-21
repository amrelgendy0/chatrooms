import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat/dash_chat.dart';
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
              "${ChatUser().uid}": {
                "name": "$name",
                "users": {"as": "as"},
              }
            });
            Firestore.instance.collection("$name").add({});
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
