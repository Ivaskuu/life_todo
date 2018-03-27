import 'package:flutter/material.dart';
import 'pages/todo_list_page/todo_list_page.dart';
import 'pages/onboard_page.dart';
import 'user.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() async
{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.getString('userName') != null) User.name = prefs.getString('userName');
  if(prefs.getString('userImage') != null) User.userImagePath = prefs.getString('userImage');
  
  User.prefs = prefs;

  runApp(new MyApp());
}

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
      home: User.name != null ? new TodoListPage() : new OnboardPage(),
    );
  }
}