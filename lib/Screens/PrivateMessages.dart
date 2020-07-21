import 'package:chatrooms/Widgets/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/streams.dart';
import 'GroupChatScreen.dart';

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
        stream: CombineLatestStream.list([
          firestore
              .collection("private")
              .where("from", isEqualTo: loggedemail)
              .snapshots(),
          firestore
              .collection("private")
              .where("to", isEqualTo: loggedemail)
              .snapshots()
        ]),
        builder: (BuildContext context,
            AsyncSnapshot<List<QuerySnapshot>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: const CircularProgressIndicator());
          } else {
            final data0 = snapshot.data[0];
            final data1 = snapshot.data[1];
            List<String> senders = [];
            data0.documents.forEach((element) {
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
            data1.documents.forEach((element) {
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
                            return GroupChatScreen(
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
