import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:level_up_firebase_with_hero/resources/flutter_firebase_hero_icons.dart';
import 'package:level_up_firebase_with_hero/topics/topic_detail.dart';

class TopicsPage extends StatefulWidget {
  TopicsPage({Key key}) : super(key: key);

  @override
  _TopicsState createState() => new _TopicsState();
}

class _TopicsState extends State<TopicsPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: new AppBar(
        title: new Text("Topics"),
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('topics')
              .orderBy("value", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Loading...');
            if (snapshot.data.documents.length == 0)
              return const Text('No Data...');
            return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                padding: const EdgeInsets.only(top: 10.0),
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  return Card(
                      child: Container(
                          child: Stack(children: <Widget>[
                    Positioned.fill(
                      child: Hero(
                        tag: ds.documentID,
                        child: Container(
                          decoration: new BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TopicDetailPage(ds)),
                        );
                      },
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                        ListTile(
                          leading: Hero(
                            tag: "${ds.documentID}_value",
                            child: Material(
                                color: Colors.transparent,
                                child: Text(
                              "${ds['value']}",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                          title: Hero(tag: "${ds.documentID}_title", child: Material(color: Colors.transparent, child: Text("${ds['title']}"),),),
                          subtitle: Hero(tag: "${ds.documentID}_desc", child: Material(color: Colors.transparent, child: Text("${ds['description']}"),),),
                        ),
                        ButtonBar(
                          children: <Widget>[
                            Hero(
                              tag: "${ds.documentID}_value_inc",
                              child: Material(child: IconButton(
                                  color: Colors.transparent,
                                  icon: Icon(FFHIcon.heart, color: Colors.red),
                                  onPressed: () {
                                    Firestore.instance
                                        .collection("topics")
                                        .document(ds.documentID)
                                        .updateData({'value': ds['value'] + 1});
                                  })),
                            ),
                            Hero(
                              tag: "${ds.documentID}_value_dec",
                              child: Material(child: IconButton(
                                  color: Colors.transparent,
                                  icon: Icon(FFHIcon.heart_empty, color: Colors.red),
                                  onPressed: () {
                                    Firestore.instance
                                        .collection("topics")
                                        .document(ds.documentID)
                                        .updateData({'value': ds['value'] - 1});
                                  }))
                              ,
                            ),
                          ],
                        )
                      ]),
                    ),
                  ])));
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
