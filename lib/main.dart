import 'package:flutter/material.dart';
import 'package:level_up_firebase_with_hero/topics/topic_list.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new TopicsPage(),
    );
  }
}
