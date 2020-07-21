import 'package:chatrooms/SendTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../messageBubbles.dart';
var firestore = Firestore.instance;
class GroupChatScreen extends StatelessWidget {
  GroupChatScreen(this.name, this.email, this.allowToWrite);
  String name;
  String email;
  bool allowToWrite;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: firestore.collection(name).orderBy("createdAt").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: const CircularProgressIndicator());
          } else {
            List<MessageBubbles> messages = [];
            snapshot.data.documents.forEach((element) {
              messages.add(MessageBubbles(
                  TEXT: element.data['text'],
                  sender: element.data['user'],
                  time: DateTime.now(),
                  isResev: element.data['user'] == email));
            });
            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                      child: ListView(
                    reverse: true,
                    children: messages.reversed.toList(),
                  )),
            allowToWrite ?      SendTextField(name, email) : Text('You must join to send',style:
            TextStyle(
              color: Colors.red,
              fontSize: 21,letterSpacing: 1.2


            ),textAlign: TextAlign.center,)
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
