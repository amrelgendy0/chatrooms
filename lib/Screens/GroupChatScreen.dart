import 'package:chatrooms/Widgets/SendTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Widgets/messageBubbles.dart';

var firestore = Firestore.instance;

class GroupChatScreen extends StatelessWidget {
  GroupChatScreen(this.name, this.email, this.allowToWrite);
  String name;
  String email;
  bool allowToWrite;
  @override
  Widget build(BuildContext context) {
    print(email);
    print(name);
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
                if(element.data['from']==email||element.data['to']==email) {
                  messages.add(MessageBubbles(
                      loggedemail: email,
                      TEXT: element.data['text'],
                      sender: element.data['from'],
                      time: DateTime.now(),
                      isResev: element.data['from'] == email));
                }

              } else {
                messages.add(MessageBubbles(
                    loggedemail: email,
                    TEXT: element.data['text'],
                    sender: element.data['user'],
                    time: DateTime.now(),
                    isResev: element.data['user'] == email));
              }
            });

//            snapshot.data.documents.forEach((element) {
//              messages.add(MessageBubbles(loggedemail: email,
//                  TEXT: element.data['text'],
//                  sender: element.data['user']??element.data['from'],
//                  time: DateTime.now(),
//                  isResev: element.data['user'] == email||element.data['from'] == email));
//            });
//            if(name.contains("@")&& email.contains("@")){
//              bool delete = false;
//              messages.forEach((element) {
//                if(element.sender==email||)
//
//
//              });

//            }

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
