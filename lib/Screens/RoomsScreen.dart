

import 'package:chatrooms/Services/servies.dart';
import 'package:chatrooms/Widgets/addroom.dart';
import 'package:chatrooms/Widgets/drawer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'ChatScreen.dart';

class app extends StatelessWidget {
  app(this.email);
  String email;
  @override
  Widget build(BuildContext context) {
    String tt = email.substring(0, email.lastIndexOf('@'));
    return Scaffold(
        drawer: drawerr(email),
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
            if (!snapshot.hasData) {
              return const Center(child: const CircularProgressIndicator());
            } else {
              Map<String, Map> data =
              (snapshot.data.snapshot.value as Map).cast();
              List<Map> handleddate = [];
              data.forEach((key, value) {
                handleddate.add({
                  "id": key,
                  "name": value['name'],
                  "users": value["users"]
                });
              });

              return GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: handleddate.map((e) {
                  bool isIN = e['users']['$tt'] == email;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return ChatScreen(e['name'], email, isIN);
                          }));
                    },
                    child: Card(
                      color: getRandomColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(e['name'],style: TextStyle(
                              fontSize: 25
                          )),
                          Text("Joined : ${e['users'].length - 1}",style: TextStyle(
                              fontSize: 20
                          ),),
                          RaisedButton(
                            color: !isIN ? Colors.blue : Colors.red,
                            onPressed: () async {
                              if (!isIN) {
                                FirebaseDatabase.instance
                                    .reference()
                                    .child("Rooms")
                                    .child("${e['id']}")
                                    .child("users")
                                    .reference()
                                    .update({"$tt": "$email"});
                              } else {
                                FirebaseDatabase.instance
                                    .reference()
                                    .child("Rooms")
                                    .child("${e['id']}")
                                    .child("users")
                                    .reference()
                                    .child('$tt')
                                    .remove();
                              }
                            },
                            child: !isIN ? Text('Join') : Text("Leave"),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }
          },
        ));
  }
}
