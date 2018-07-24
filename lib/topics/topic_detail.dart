import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TopicDetailPage extends StatefulWidget {
  TopicDetailPage(this.documentId, {Key key}) : super(key: key);

  final String documentId;

  @override
  _TopicDetailState createState() => new _TopicDetailState(documentId);
}

class _TopicDetailState extends State<TopicDetailPage> {
  _TopicDetailState(this.documentId);

  final String documentId;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
//        fiapp bind name
        title: StreamBuilder(
            stream: Firestore.instance.collection('topics').document(documentId).snapshots(),
            builder: (context, snapshot) {
              return Text("${snapshot.data["title"]}");
            }),
      ),
      //        fiapp bind desc
      body: StreamBuilder(
          stream: Firestore.instance.collection('topics').document(documentId).snapshots(),
          builder: (context, snapshot) {
            return Text("${snapshot.data["description"]}");
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
