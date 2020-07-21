import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';

class GroupChatScreen extends StatelessWidget {
  final _firestore = Firestore.instance;
  GroupChatScreen(this.name, this.email, this.allowToWrite);
  String name;
  String email;
  bool allowToWrite;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _firestore.collection(name).orderBy("createdAt").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: const CircularProgressIndicator());
          } else {
            List<ChatMessage> messages = [];
            snapshot.data.documents.forEach((element) {
              messages.add(ChatMessage(
                  text: element.data['text'],
                  user: ChatUser(name: element.data['user']),
                  createdAt: DateTime.parse(element.data['createdAt']),
                  id: element.data['id']));
            });
            return DashChat(
              readOnly: !allowToWrite,
              user: ChatUser(
                color: Colors.red,
                uid: "$email",
                name: '$email',
                avatar: '$email',
                firstName: '$email',
              ),
              onSend: (ChatMessage) {
                _firestore.collection(name).add({
                  "text": "${ChatMessage.text}",
                  "user": "${ChatMessage.user.name}",
                  "createdAt": "${ChatMessage.createdAt}",
                  "id": "${ChatMessage.id}",
                });
              },
              messages: <ChatMessage>[...messages],
            );
          }
        },
      ),
    );
  }
}
