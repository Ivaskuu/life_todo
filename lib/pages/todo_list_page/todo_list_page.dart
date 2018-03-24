import 'package:flutter/material.dart';

import 'progress_bar.dart';
import 'tasks_section.dart';

class TodoListPage extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return new Scaffold
    (
      appBar: new AppBar
      (
        elevation: 0.0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        title: new Text('Life story', style: new TextStyle(color: Colors.black, fontSize: 32.0, fontWeight: FontWeight.w600)),
        actions: <Widget>
        [
          new Container
          (
            margin: new EdgeInsets.only(right: 10.0),
            child: new Material
            (
              elevation: 2.0,
              shape: new CircleBorder(),
              child: new CircleAvatar
              (
                radius: 22.0,
                backgroundColor: Colors.white,
                backgroundImage: new AssetImage('res/me.png'),
              ),
            )
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: new ListView
      (
        children: <Widget>
        [
          new Padding(padding: new EdgeInsets.all(12.0)),
          new ProgressBar(),
          new Container
          (
            margin: new EdgeInsets.only(right: 18.0, bottom: 8.0, top: 24.0),
            child: new Text('Tasks list', textAlign: TextAlign.end, style: new TextStyle(fontWeight: FontWeight.w500)),
          ),
          new TasksSection()
        ],
      )
    );
  }
}