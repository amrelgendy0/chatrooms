import 'package:chatrooms/Widgets/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'ChatScreen.dart';

class PrivateMessageScreen extends StatelessWidget {
  PrivateMessageScreen(this.loggedemail);
  String loggedemail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerr(loggedemail),
      appBar: AppBar(
        title: Text('Private Messages'),
      ),
      body: StreamBuilder(
        stream: firestore
            .collection("private")
            .where("RightsToSee", arrayContains:  loggedemail)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: const CircularProgressIndicator());
          } else {
            List<String> senders = [];
            snapshot.data.documents.forEach((element) {
              if (loggedemail == element.data['from']) {
                if (!senders.contains(element.data['to'])) {
                  senders.add(element.data['to']);
                }
              } else {
                if (!senders.contains(element.data['from'])) {
                  senders.add(element.data['from']);
                }
              }
            });
            return ListView(
              children: senders
                  .map((e) => ListTile(
                        title: Text(e),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return ChatScreen(
                                e, loggedemail, true);
                          }));
                        },
                      ))
                  .toList(),
            );
          }
        },
      ),
    );
  }
}
