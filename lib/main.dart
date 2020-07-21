import 'package:chatrooms/Screens/singup.dart';
import 'package:chatrooms/addroom.dart';
import 'package:chatrooms/servies.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chatrooms',
      home: Signupscreen(),
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
            onPressed: (){
              showDialog(context: context,child: Addroom());


            },


          )
        ],
        title: Text("Room App"),
      ),
      body: StreamBuilder<Event>(
        stream: FirebaseDatabase.instance.reference().child("Rooms").onValue,
        builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
          Map<String, Map> data = (snapshot.data.snapshot.value as Map).cast();
          List<int> Groupsid = [];
          List<String> groupnames = [];
          data.forEach((key, value) {
            Groupsid.add(int.parse(key));
            groupnames.add(value['name']);
          });
          return GridView(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            children: groupnames
                .map((e) => Card(
                      color: getRandomColor,
                      child: Text(e),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
