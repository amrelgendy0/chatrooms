import 'package:chatrooms/Screens/login.dart';
import 'package:chatrooms/Screens/singup.dart';
import 'package:chatrooms/addroom.dart';
import 'package:chatrooms/providers/ModelHud.dart';
import 'package:chatrooms/servies.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ModelHud();
      },
      child: MaterialApp(
        title: 'chatrooms',
        home: LoginScreen(),
      ),
    );
  }
}

class app extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(context: context, child: Addroom());
            },
          )
        ],
        title: Text("Room App"),
      ),
      body: StreamBuilder<Event>(
        stream: FirebaseDatabase.instance.reference().child("Rooms").onValue,
        builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
          Map<String, Map> data = (snapshot.data.snapshot.value as Map).cast();
          List<Map<String, Map> handleddate = [];
          data.forEach((key, value) {
            handleddate.add(

                      );
          });
          return GridView(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            children: handleddate
                .map((e) => Card(
                      color: getRandomColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(e),
                          FlatButton(
                            onPressed: () {
                              FirebaseDatabase.instance
                                  .reference()
                                  .child("Rooms")
                                  .child("")
                                  .update({
//                              "${Random().nextInt(99999999)}": {"name": "$name"}
                              });
                            },
                            child: Text('Join'),
                          )
                        ],
                      ),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
