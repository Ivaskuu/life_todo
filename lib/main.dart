import 'package:flutter/material.dart';
import 'misc/mycolors.dart';
import 'pages/todo_list_page/todo_list_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return new MaterialApp
    (
      title: 'Life Todo',
      theme: new ThemeData
      (
        primarySwatch: Colors.blue,
      ),
      home: new TodoListPage(),
    );
  }
}