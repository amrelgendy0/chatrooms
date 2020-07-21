import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'GroupChatScreen.dart';

class PrivateMessageScreen extends StatelessWidget {
  PrivateMessageScreen(this.loggedemail);
  String loggedemail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: firestore.collection(loggedemail).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          List<String> senders = [];
          snapshot.data.documents.forEach((element) {
            if (!senders.contains(element.data['user']) &&
                element.data['user'] != loggedemail) {
              senders.add(element.data['user']);
            }
          });
          return ListView(
            children: senders
                .map((e) => ListTile(
                      title: Text(e),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return GroupChatScreen(
                              loggedemail, loggedemail, true);
                        }));
                      },
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
