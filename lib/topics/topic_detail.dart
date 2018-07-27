import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:level_up_firebase_with_hero/resources/flutter_firebase_hero_icons.dart';

class TopicDetailPage extends StatefulWidget {
  TopicDetailPage(this.snapshots, {Key key}) : super(key: key);

  final DocumentSnapshot snapshots;

  @override
  _TopicDetailState createState() => new _TopicDetailState(snapshots);
}

class _TopicDetailState extends State<TopicDetailPage> {
  _TopicDetailState(this.snapshots);

  final DocumentSnapshot snapshots;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return new Stack(children: <Widget>[
      Hero(
        tag: snapshots.documentID,
        child: new Container(
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.circular(0.0),
          ),
        ),
      ),
      new Scaffold(
        backgroundColor: Colors.transparent,
        appBar: new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SizedBox.expand(
          child: Container(
              color: Colors.transparent,
              child: StreamBuilder(
                  stream: Firestore.instance
                      .collection("topics")
                      .document(snapshots.documentID)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return Column(
                      children: <Widget>[
                        Hero(
                          tag: "${snapshots.documentID}_title",
                          child: Material(
                            color: Colors.transparent,
                            child: Text(snapshot.hasData
                                ? snapshot.data['title']
                                : snapshots['title']),
                          ),
                        ),
                        Hero(
                          tag: "${snapshots.documentID}_desc",
                          child: Material(
                            color: Colors.transparent,
                            child: Text(snapshot.hasData
                                ? snapshot.data['description']
                                : snapshots['description']),
                          ),
                        ),
                        Hero(
                          tag: "${snapshots.documentID}_value",
                          child: Material(
                              color: Colors.transparent,
                              child: Text(
                                snapshot.hasData
                                    ? "${snapshot.data['value']}"
                                    : "${snapshots['value']}",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        Hero(
                          tag: "${snapshots.documentID}_value_inc",
                          child: Material(
                              color: Colors.transparent,
                              child: IconButton(
                                  icon: Icon(FFHIcon.heart, color: Colors.red),
                                  onPressed: () {
                                    Firestore.instance
                                        .collection("topics")
                                        .document(snapshots.documentID)
                                        .updateData({
                                      'value': snapshot.data['value'] + 1
                                    });
                                  })),
                        ),
                        Hero(
                          tag: "${snapshots.documentID}_value_dec",
                          child: Material(
                              color: Colors.transparent,
                              child: IconButton(
                                  icon: Icon(FFHIcon.heart_empty,
                                      color: Colors.red),
                                  onPressed: () {
                                    Firestore.instance
                                        .collection("topics")
                                        .document(snapshots.documentID)
                                        .updateData({
                                      'value': snapshot.data['value'] - 1
                                    });
                                  })),
                        ),
                      ],
                    );
                  })),
        ),
      )
    ]);
  }
}
