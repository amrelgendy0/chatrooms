import 'package:chatrooms/Screens/ChatScreen.dart';
import 'package:chatrooms/Screens/login.dart';
import 'package:chatrooms/Widgets/addroom.dart';
import 'package:chatrooms/Widgets/drawer.dart';
import 'package:chatrooms/providers/ModelHud.dart';
import 'package:chatrooms/Services/servies.dart';
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
