import 'package:chatrooms/Screens/PrivateMessages.dart';
import 'package:chatrooms/Screens/RoomsScreen.dart';
import 'package:flutter/material.dart';

class drawerr extends StatelessWidget {
  drawerr(this.email);
  String email;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text(email),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            title: Text('Rooms'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return app(email);
                  }));
            },
          ),
          ListTile(onTap: (){
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) {
                  return PrivateMessageScreen(email);
                }));
          },
            title: Text('PrivateMessage'),
          ),
        ],
      ),
    );
  }
}
