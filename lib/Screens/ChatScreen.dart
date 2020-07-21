import 'package:chatrooms/Widgets/SendTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Widgets/messageBubbles.dart';
var firestore = Firestore.instance;
class ChatScreen extends StatelessWidget {
  ChatScreen(this.name, this.email, this.allowToWrite);
  String name;
  String email;
  bool allowToWrite;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(name),
      ),
      body: StreamBuilder(
        stream: name.contains("@") && email.contains("@")
            ? firestore.collection("private").orderBy("createdAt").snapshots()
            : firestore.collection(name).orderBy("createdAt").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: const CircularProgressIndicator());
          } else {
            List<MessageBubbles> messages = [];
            snapshot.data.documents.forEach((element) {
              if (name.contains("@") && email.contains("@")) {
                if ((element.data['RightsToSee'] as List).contains(email)&&(element.data['RightsToSee'] as List).contains(name)) {
                  messages.add(MessageBubbles(
                      loggedemail: email,
                      TEXT: element.data['text'],
                      sender: element.data['from'],
                      time: element.data['createdAt'],
                      isResev: element.data['from'] == email));
                }
              } else {
                messages.add(MessageBubbles(
                    loggedemail: email,
                    TEXT: element.data['text'],
                    sender: element.data['user'],
                    time: element.data['createdAt'],
                    isResev: element.data['user'] == email));
              }
            });
            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                      child: ListView(
                    reverse: true,
                    children: messages.reversed.toList(),
                  )),
                  allowToWrite
                      ? SendTextField(name, email)
                      : Text(
                          'You must join to send',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 21,
                              letterSpacing: 1.2),
                          textAlign: TextAlign.center,
                        )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
