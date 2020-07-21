import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chatrooms',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Room App"),
        ),

      ),
    );
  }
}
