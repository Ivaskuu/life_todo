import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../user.dart';
import 'onboard_page.dart';
import '../misc/user_image.dart';
import '../misc/io_manager.dart';
import '../misc/tasks_list.dart';
import '../misc/mycolors.dart';

import 'package:share/share.dart';

class MenuPage extends StatefulWidget
{
  State todoListPageState;
  MenuPage(this.todoListPageState);

  @override
  _MenuPageState createState() => new _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
{
  @override
  Widget build(BuildContext context)
  {
    return new Column
    (
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>
      [
        // Upper part
        new Column
        (
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>
          [
            /// Profile infos
            new SizedBox.fromSize
            (
              size: new Size.fromHeight(250.0),
              child: new Stack
              (
                alignment: Alignment.center,
                children: <Widget>
                [
                  /// Upper gradient
                  new SizedBox.expand
                  (
                    child: new Container
                    (
                      decoration: new BoxDecoration(gradient: new LinearGradient(colors: [ new Color(0xFF0acffe), new Color(0xFF495aff) ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                    ),
                  ),
                  /// Black transparent overlay
                  new SizedBox.expand
                  (
                    child: new Container
                    (
                      color: Colors.black38,
                    ),
                  ),
                  /// Name, tasks num and share button
                  new Align
                  (
                    alignment: Alignment.bottomLeft,
                    child: new Container
                    (
                      margin: new EdgeInsets.all(24.0),
                      child: new Row
                      (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>
                        [
                          new Column
                          (
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>
                            [
                              new Container
                              (
                                margin: new EdgeInsets.only(bottom: 24.0),
                                child: new Material
                                (
                                  elevation: 4.0,
                                  shape: new CircleBorder(),
                                  child: new CircleAvatar
                                  (
                                    radius: 42.0,
                                    child: new InkWell
                                    (
                                      onTap: () => changeUserImage(),
                                      onLongPress: () => removeUserImage(),
                                      child: new UserImage(),
                                    ),
                                  ),
                                ),
                              ),
                              new Text(User.name, style: new TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.w500)),
                              new Text(User.completedTasks.length.toString() + ' completed tasks out of ' + TasksList.tasks.length.toString(), style: new TextStyle(color: Colors.white))
                            ],
                          ),
                          new Material
                          (
                            shape: new CircleBorder(),
                            color: Colors.transparent,
                            child: new IconButton
                            (
                              onPressed: () => share(User.name + ' has completed ' + User.completedTasks.length.toString() + ' tasks in Life Todo! Can you beat him?\n\nDownload it here: https://play.google.com/store/apps/details?id=com.skuu.lifetodo'),
                              icon: new Icon(Icons.share, color: Colors.white),
                            )
                          )
                        ],
                      )
                    )
                  )
                ],
              ),
            ),
            /// Menu buttons
            new Padding(padding: new EdgeInsets.only(top: 16.0)),
            new FlatButton
            (
              //onPressed: () { },
              child: new ListTile
              (
                title: new Text("My friends (soon)", style: new TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 20.0)),
                leading: new Icon(Icons.people, color: Colors.grey),
              ),
            ),
            new FlatButton
            (
              onPressed: () { showAboutDialog(context: context, applicationLegalese: 'Check the privacy policy at:\n\nhttps://gist.githubusercontent.com/Ivaskuu/9f1891f62189289e7d9a7c31e297a98a/raw/fb813af5940de6fe30efcd8e0a63bca1d4ee7a55/Life%2520todo%2520privacy%2520policy', applicationVersion: 'Beta: v0.2', applicationIcon: new Image.asset('res/icon.png', width: 80.0)); },
              child: new ListTile
              (
                title: new Text("About", style: new TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20.0)),
                leading: new Icon(Icons.info),
              ),
            ),
          ],
        ),
        // Logout button
        new Container
        (
          margin: new EdgeInsets.only(bottom: 32.0, left: 32.0, right: 32.0),
          child: new RaisedButton
          (
            color: Colors.pink,
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
              title: new Text("LOGOUT", style: new TextStyle(color: Colors.white)),
              trailing: new Icon(Icons.exit_to_app, color: Colors.white),
            )
          )
        )
      ],
    );
  }

  changeUserImage() async
  {
    var _fileName = await ImagePicker.pickImage();
    User.prefs.setString('userImage', _fileName.path);
    User.prefs.commit();

    User.userImagePath = _fileName.path;
    setState(() {});
    widget.todoListPageState.setState(() {});
  }

  removeUserImage() async
  {
    User.prefs.setString('userImage', null);
    User.prefs.commit();

    User.userImagePath = null;
    setState(() {});
    widget.todoListPageState.setState(() {});
  }
}