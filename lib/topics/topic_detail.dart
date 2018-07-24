import 'package:flutter/material.dart';

class TopicDetailPage extends StatefulWidget {
  TopicDetailPage(this.title, {Key key}) : super(key: key);

  final String title;

  @override
  _TopicDetailState createState() => new _TopicDetailState();
}

class _TopicDetailState extends State<TopicDetailPage> {

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
        title: new Text(widget.title),
      ),
      body: Text("Second Page"),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
