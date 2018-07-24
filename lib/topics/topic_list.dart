import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
      appBar: new AppBar(
        title: new Text("Topics"),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('topics').snapshots(),
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
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TopicDetailPage(ds.documentID)),
                            );
                          },
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: const Icon(Icons.settings_power),
                                title: Text("${ds['title']}"),
                                subtitle: Text("${ds['description']}"),
                              ),
                            ],
                          )));
                });
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
