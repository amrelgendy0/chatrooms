import 'package:chatrooms/Screens/GroupChatScreen.dart';
import 'package:chatrooms/Services/auth.dart';
import 'package:flutter/material.dart';

class MessageBubbles extends StatelessWidget {
  MessageBubbles(
      {this.sender,
      this.TEXT,
      this.isResev,
      this.time,
      @required this.loggedemail}) {
    if (isResev) {
      Col = Colors.green[800];
      cc = CrossAxisAlignment.start;
      R = BorderRadius.only(
          topRight: Radius.circular(redius),
          bottomLeft: Radius.circular(redius),
          bottomRight: Radius.circular(redius));
    } else {
      Col = Colors.grey[700];
      cc = CrossAxisAlignment.end;
      R = BorderRadius.only(
          topLeft: Radius.circular(redius),
          bottomLeft: Radius.circular(redius),
          bottomRight: Radius.circular(redius));
    }
  }
  String loggedemail;
  double redius = 18;
  var time;
  CrossAxisAlignment cc;
  bool isResev;
  var sender;
  var TEXT;
  Color Col;
  BorderRadius R;

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
                    print("$loggedemail $sender");

                return GroupChatScreen(sender, loggedemail, true);
              }));
            }
          },
          child: Text(sender.toString()),
        ),
        Material(
          elevation: 10,
          textStyle: TextStyle(fontSize: 25, color: Colors.white),
          borderRadius: R,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              TEXT.toString(),
              textAlign: TextAlign.center,
            ),
          ),
          color: Col,
        ),
        Text(
          time.toString(),
          style: TextStyle(color: Colors.brown),
        )
      ],
    );
  }
}
