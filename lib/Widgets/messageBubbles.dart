import 'package:chatrooms/Screens/ChatScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubbles extends StatelessWidget {
  String loggedemail;
  double redius = 18;
  Timestamp time;
  CrossAxisAlignment cc;
  bool isResev;
  String  sender;
  String  TEXT;
  Color Col;
  BorderRadius R;
  MessageBubbles(
      {this.sender,
      this.TEXT,
      this.isResev,
      this.time,
      @required this.loggedemail}) {
    Col = isResev ? Colors.green[800] : Colors.grey[700];
    cc = isResev ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    R = isResev
        ? BorderRadius.only(
            topRight: Radius.circular(redius),
            bottomLeft: Radius.circular(redius),
            bottomRight: Radius.circular(redius))
        : BorderRadius.only(
            topLeft: Radius.circular(redius),
            bottomLeft: Radius.circular(redius),
            bottomRight: Radius.circular(redius));
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: cc,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (loggedemail == sender) {
            } else {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return ChatScreen(sender, loggedemail, true);
              }));
            }
          },
          child: Text(sender),
        ),
        Material(
          elevation: 10,
          textStyle: TextStyle(fontSize: 25, color: Colors.white),
          borderRadius: R,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              TEXT,
              textAlign: TextAlign.center,
            ),
          ),
          color: Col,
        ),
        Text(
          "${time.toDate().hour}:${time.toDate().minute}",
          style: TextStyle(color: Colors.brown),
        )
      ],
    );
  }
}
