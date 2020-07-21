import 'package:chatrooms/Screens/ChatScreen.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SendTextField extends StatelessWidget {
  SendTextField(this.RoomNAme, this.email);
  TextEditingController _controller = new TextEditingController();
  String RoomNAme;
  String email;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 2.0,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.send,
              controller: _controller,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                hintText: 'Type your message here...',
                border: InputBorder.none,
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              send(_controller.text, email, RoomNAme);
            },
            child: Text(
              'Send',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void send(String text, String user, String RoomName) {
    if (text.trim() == '') {
    } else {
      if (RoomName.contains("@") && user.contains("@")) {
        firestore.collection("private").add({
          "text": text,
          "from": user,
          "to": RoomName,
          "RightsToSee": [user, RoomName],
          "createdAt": DateTime.now(),
          "id": Uuid().v5(text, DateTime.now().toString()),
        });
      } else {
        firestore.collection(RoomName).add({
          "text": text,
          "user": user,
          "createdAt": DateTime.now(),
          "id": Uuid().v5(text, DateTime.now().toString()),
        });
      }
      _controller.clear();
    }
  }
}
