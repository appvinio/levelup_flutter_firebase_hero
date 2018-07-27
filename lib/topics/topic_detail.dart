import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
              icon: new Icon(Icons.arrow_back, color: Colors.blue,),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Center(
              child: StreamBuilder(
                  builder: (context, snapshot) {
                    var value = snapshot.hasData ? snapshot.data['value'] : snapshots['value'];
                    return Hero(
                      tag: "${snapshots.documentID}_value",
//                            fiapp Material for better Animation bounds
                      child: Material(
                        child: Text(
                          "$value",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }
              )
          ),
      )
    ]);
  }
}
