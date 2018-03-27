import 'package:flutter/material.dart';
import '../user.dart';
import 'onboard_page.dart';
import '../misc/user_image.dart';
import '../misc/io_manager.dart';
import '../misc/tasks_list.dart';

class MenuPage extends StatefulWidget
{
  @override
  _MenuPageState createState() => new _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
{
  @override
  Widget build(BuildContext context)
  {
    return new Scaffold
    (
      body: new Column
      (
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>
        [
          new Container
          (
            margin: new EdgeInsets.only(top: 64.0),
            child:   new Row
            (
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>
              [
                new Material
                (
                  color: Colors.transparent,
                  elevation: 6.0,
                  shape: new CircleBorder(),
                  child: new CircleAvatar
                  (
                    radius: 32.0,
                    backgroundColor: Colors.white,
                    child: new UserImage(),
                  ),
                ),
                new Padding(padding: new EdgeInsets.only(right: 32.0)),
                new Column
                (
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>
                  [
                    new Text(User.name, style: new TextStyle(fontSize: 32.0, fontWeight: FontWeight.w500)),
                    new Text(User.completedTasks.length.toString() + ' completed tasks over ' + TasksList.tasks.length.toString())
                  ],
                )
              ],
            ),
          ),
          new Container
          (
            margin: new EdgeInsets.only(bottom: 32.0),
            child: new Material
            (
              elevation: 4.0,
              child: new Container
              (
                decoration: new BoxDecoration
                (
                  gradient: new LinearGradient
                  (
                    colors: [ Colors.yellow, Colors.red ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight
                  )
                ),
                child: new Material
                (
                  color: Colors.transparent,
                  child: new InkWell
                  (
                    onTap: () async
                    {
                      User.prefs.setString('userName', null);
                      User.prefs.setString('userImage', null);
                      await User.prefs.commit();

                      IOManager.saveCompletedTasks();
                      User.userImagePath = null;
                      User.completedTasks = new List();

                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (_) => new OnboardPage()));
                    },
                    child: new Container
                    (
                      margin: new EdgeInsets.symmetric(horizontal: 52.0, vertical: 16.0),
                      child: new Text('SIGN OUT', style: new TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.white)),
                    )
                  ),
                ),
              ),
            )
          ),
        ],
      )
    );
  }
}