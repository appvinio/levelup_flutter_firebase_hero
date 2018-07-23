import 'package:flutter/material.dart';
//fiapp import firestore
import 'package:cloud_firestore/cloud_firestore.dart';

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

class TopicsPage extends StatefulWidget {
  TopicsPage({Key key}) : super(key: key);

  @override
  _TopicsState createState() => new _TopicsState();
}

class _TopicsState extends State<TopicsPage> {
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
        title: new Text("Topics"),
      ),
      body: StreamBuilder(
        key: Key("asdasd"),
        //fiapp connect to firebase
          stream: Firestore.instance.collection('topics').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Loading...');
            if (snapshot.data.documents.length == 0)
              return const Text('No Data...');
            return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                padding: const EdgeInsets.only(top: 10.0),
                itemBuilder: (context, index) {
                  //fiapp bind data
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  return Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        InkWell(
                          onTap: () {},
                          child: ListTile(
                            leading: const Icon(Icons.settings_power),
                            title: Text("${ds['title']}"),
                            subtitle: Text("${ds['description']}"),
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
