import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'todo_list_page/todo_list_page.dart';

import '../misc/user_image.dart';
import '../user.dart';
import 'dart:io';

class LoginPage extends StatefulWidget
{
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
{
  File profileImageFile;
  TextEditingController controller = new TextEditingController();
  LinearGradient transparentToWhite = new LinearGradient
  (
    colors: [ Colors.red, Colors.transparent ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter
  );

  @override
  Widget build(BuildContext context)
  {
    return new Scaffold
    (
      backgroundColor: Colors.white,
      body: new PageView
      (
        children: <Widget>
        [
          new Stack
          (
            children: <Widget>
            [
              new SizedBox.expand
              (
                child: new Image.asset('res/forest.jpg', fit: BoxFit.cover)
              ),
              new Align
              (
                alignment: FractionalOffset.topCenter,
                child: new Container
                (
                  margin: new EdgeInsets.only(left: 32.0, top: 48.0, right: 16.0),
                  child: new Column
                  (
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>
                    [
                      new Text('Life story.', style: new TextStyle(fontWeight: FontWeight.w700, fontSize: 48.0, color: Colors.white)),
                      new Padding(padding: new EdgeInsets.only(bottom: 4.0)),
                      new Text('What have you done in your life?', style: new TextStyle(color: Colors.white))
                    ],
                  )
                )
              ),
              new Align
              (
                alignment: Alignment.center,
                child: new Container
                (
                  margin: new EdgeInsets.symmetric(horizontal: 32.0),
                  child: new Material
                  (
                    elevation: 8.0,
                    child: new Column
                    (
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>
                      [
                        new SizedBox.fromSize
                        (
                          size: new Size.fromHeight(200.0),
                          child: new Material
                          (
                            child: new Stack
                            (
                              children: <Widget>
                              [
                                new Center
                                (
                                  child: new UserImage()
                                ),
                                new Align
                                (
                                  alignment: Alignment.topRight,
                                  child: new Container
                                  (
                                    child: new IconButton
                                    (
                                      onPressed: () => getImage(),
                                      icon: new Icon(Icons.add_a_photo),
                                    ),
                                  )
                                )
                              ],
                            )
                          ),
                        ),
                        new Container
                        (
                          margin: new EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
                          child: new TextField
                          (
                            controller: controller,
                            decoration: new InputDecoration.collapsed
                            (
                              hintText: 'Your name'
                            )
                          ),
                        )
                      ],
                    )
                  ) 
                )
              ),
              new Align
              (
                alignment: Alignment.center,
                child: new Container
                (
                  margin: new EdgeInsets.only(top: 500.0),
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
                          onTap: () => saveNameAndContinue(controller.text),
                          child: new Container
                          (
                            margin: new EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                            child: new Text('CONTINUE', style: new TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.white)),
                          )
                        ),
                      ),
                    ),
                  )
                )
              )
            ]
          )
        ]
      )
    );
  }

  getImage() async
  {
    var _fileName = await ImagePicker.pickImage();

    setState(()
    {
      profileImageFile = _fileName;
    });

    User.prefs.setString('userImage', _fileName.path);
    User.prefs.commit();

    User.userImagePath = _fileName.path;
  }

  saveNameAndContinue(String userName) async
  {
    User.prefs.setString('userName', userName);
    await User.prefs.commit();

    User.name = userName;
    Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (_) => new TodoListPage()));
  }
}