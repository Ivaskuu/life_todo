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
          new Column
          (
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>
            [
              /// Profile infos
              new Container
              (
                margin: new EdgeInsets.only(top: 48.0),
                child: new Row
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
              /// Menu buttons
              new Padding(padding: new EdgeInsets.only(top: 48.0)),
              new FlatButton
              (
                //onPressed: () { },
                child: new ListTile
                (
                  title: new Text("My friends", style: new TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20.0)),
                  leading: new Icon(Icons.people, ),
                ),
              ),
              new FlatButton
              (
                onPressed: () {  },
                child: new ListTile
                (
                  title: new Text("About", style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
                  leading: new Icon(Icons.info,),
                ),
              ),
            ],
          ),
          new Container
          (
            margin: new EdgeInsets.only(bottom: 32.0, left: 32.0, right: 32.0),
            child: new RaisedButton
            (
              color: Colors.white,
              onPressed: () async
              {
                User.prefs.setString('userName', null);
                User.prefs.setString('userImage', null);
                User.prefs.setBool('rateDialog', null);
                await User.prefs.commit();

                IOManager.saveCompletedTasks();
                User.userImagePath = null;
                User.completedTasks = new List();

                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (_) => new OnboardPage()));
              },
              child: new ListTile
              (
                title: new Text("LOGOUT", style: new TextStyle(color: Colors.blueAccent)),
                trailing: new Icon(Icons.exit_to_app, color: Colors.blueAccent),
              )
            )
          )
        ],
      )
    );
  }

  Widget menuButton(String title)
  {
    return new InkWell
    (
      onTap: () {},
      child: new ListTile
      (
        title: new Text(title, style: new TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 32.0)),
      )
    );
  }
}