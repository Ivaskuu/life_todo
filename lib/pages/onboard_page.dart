import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'todo_list_page/todo_list_page.dart';
import '../misc/user_image.dart';
import '../misc/tasks_list.dart';
import '../user.dart';
import 'dart:io';
import '../misc/mycolors.dart';
import '../misc/io_manager.dart';

bool card1 = false;
bool card2 = false;

class OnboardPage extends StatefulWidget
{
  @override
  _OnboardPageState createState() => new _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage>
{
  AssetImage bgImage;
  File profileImageFile;
  PageController pageController = new PageController();
  TextEditingController controller = new TextEditingController();
  LinearGradient transparentToWhite = new LinearGradient
  (
    colors: [ Colors.red, Colors.transparent ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter
  );

  @override
  void initState()
  {
    super.initState();
    bgImage = new AssetImage('res/forest.jpg');
    bgImage.resolve(ImageConfiguration.empty);
  }

  @override
  Widget build(BuildContext context)
  {
    return new Scaffold
    (
      backgroundColor: Colors.white,
      body: new PageView
      (
        physics: new NeverScrollableScrollPhysics(),
        controller: pageController,
        children: <Widget>
        [
          onboardPage(Icons.show_chart, 'Keep track of your life.', '1/3'),
          onboardPage(Icons.map, 'Discover new adventures to live.', '2/3'),
          onboardPage(Icons.people, 'Share with your friends (soon).', '3/3'),
          nameAndImagePage(),
          tutorialPage()
        ]
      )
    );
  }

  Widget onboardPage(IconData icon, String text, String pageNum)
  {
    return new Column
    (
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>
      [
        new Flexible
        (
          flex: 1,
          child: new Container
          (
            decoration: new BoxDecoration(gradient: new LinearGradient(colors: [ new Color(0xFF0acffe), new Color(0xFF495aff) ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: new Center
            (
              child: new Icon(icon, color: Colors.white, size: 120.0),
            ),
          ),
        ),
        new Flexible
        (
          flex: 1,
          child: new Container
          (
            margin: new EdgeInsets.all(32.0),
            child: new Column
            (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>
              [
                new Text(text, style: new TextStyle(fontSize: 34.0, fontWeight: FontWeight.w800, color: Colors.black)),
                new Row
                (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>
                  [
                    new Text(pageNum),
                    new IconButton
                    (
                      onPressed:() => pageController.nextPage(duration: new Duration(milliseconds: 500), curve: Curves.easeInOut),
                      icon: new Icon(Icons.arrow_forward, color: Colors.black),
                    )
                  ],
                )
              ],
            )
          )
        )
      ],
    );
  }

  Widget nameAndImagePage()
  {
    return new Stack
    (
      children: <Widget>
      [
        new Container
        (
          decoration: new BoxDecoration
          (
            image: new DecorationImage
            (
              image: bgImage,
              fit: BoxFit.cover
            )
          ),
        ),
        new ListView
        (
          children: <Widget>
          [
            /// Logo
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
                    new Text('Life Todo.', style: new TextStyle(fontWeight: FontWeight.w700, fontSize: 48.0, color: Colors.white)),
                    new Padding(padding: new EdgeInsets.only(bottom: 4.0)),
                    new Text('Your life checklist ✅', style: new TextStyle(color: Colors.white))
                  ],
                )
              )
            ),
            /// Image and name card
            new Padding(padding: new EdgeInsets.only(bottom: 32.0)),
            new Container
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
                      margin: new EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                      child: new TextField
                      (
                        controller: controller,
                        decoration: new InputDecoration.collapsed(hintText: 'What\'s your name?'),
                        onChanged: (_) => setState(() {}),
                        style: new TextStyle(fontSize: 18.0, color: Colors.black),
                      ),
                    )
                  ],
                )
              ) 
            ),
            /// Continue button
            new Align
            (
              alignment: Alignment.center,
              child: new Container
              (
                margin: new EdgeInsets.only(top: 48.0),
                child: new Material
                (
                  elevation: controller.text.length >= 4 && controller.text.length <= 10 ? 4.0 : 0.0,
                  child: new Container
                  (
                    decoration: controller.text.length >= 4 && controller.text.length <= 10
                    ? new BoxDecoration
                    (
                      gradient: new LinearGradient(colors: [ new Color(0xFF0acffe), new Color(0xFF495aff) ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    )
                    : new BoxDecoration
                    (
                      color: Colors.grey
                    ),
                    child: new Material
                    (
                      color: Colors.transparent,
                      child: new InkWell
                      (
                        onTap: () => controller.text.length >= 4 && controller.text.length <= 10 ? saveName(controller.text) : null,
                        child: new Container
                        (
                          margin: new EdgeInsets.symmetric(horizontal: 90.0, vertical: 16.0),
                          child: new Text('CONTINUE', style: new TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.white)),
                        )
                      ),
                    ),
                  ),
                )
              ),
            )
          ].reversed.toList(),
          shrinkWrap: true,
          reverse: true,
        ),
      ]
    );
  }

  Widget tutorialPage()
  {
    return new Container
    (
      margin: new EdgeInsets.only(top: 24.0),
      child: new Column
      (
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>
        [
          new Container
          (
            margin: new EdgeInsets.only(left: 24.0, right: 2.0, top: 16.0),
            child: new Text('Hey ${User.name},', style: new TextStyle(fontSize: 42.0, fontWeight: FontWeight.w800, color: Colors.black)),
          ),
          new Container
          (
            margin: new EdgeInsets.only(left: 24.0, right: 24.0, bottom: 16.0),
            child: new Text('nice to meet you!', style: new TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600, color: Colors.black)),
          ),
          new Container
          (
            margin: new EdgeInsets.only(left: 24.0, right: 24.0, bottom: 48.0),
            child: new Text('To complete tasks, click the checkbox, or click anywhere on the card. It should become blue.', style: new TextStyle(fontSize: 18.0)),
          ),
          new Container
          (
            margin: new EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12.0),
            child: new Material
            (
              elevation: 2.0,
              color: card1 ? MyColors.blue : Colors.white,
              child: new Material
              (
                color: Colors.transparent,
                child: new InkWell
                (
                  onTap: ()
                  {
                    setState(() => card1 = !card1);
                    
                    if(card1) User.completedTasks.add(TasksList.tasks[0]);
                    else User.removeTask(TasksList.tasks[0].description);

                    IOManager.saveCompletedTasks();
                  },
                  child: new Container
                  (
                    padding: new EdgeInsets.all(16.0),
                    child: new Column
                    (
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>
                      [
                        /// Emoji text
                        new Row
                        (
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>
                          [
                            /// Task emoji
                            new Flexible
                            (
                              child: new Text(TasksList.tasks[0].emoji, style: new TextStyle(fontSize: 28.0)),
                            ),
                          ],
                        ),
                        new Padding(padding: new EdgeInsets.only(bottom: 16.0)),
                        new Row
                        (
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>
                          [
                            /// Task description
                            new Flexible
                            (
                              child: new Text
                              (
                                TasksList.tasks[0].description.endsWith('.') ?  TasksList.tasks[0].description :  TasksList.tasks[0].description + '.',
                                style: new TextStyle(color: card1 ? Colors.white : Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500)
                              ),
                            ),
                            new Checkbox
                            (
                              onChanged: (bool newState)
                              {
                                setState(() => card1 = newState);
                                
                                if(newState) User.completedTasks.add(TasksList.tasks[0]);
                                else User.removeTask(TasksList.tasks[0].description);

                                IOManager.saveCompletedTasks();
                              },
                              activeColor: MyColors.blue,
                              value: card1,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ),
              )
            ),
          ),
          new Container
          (
            margin: new EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12.0),
            child: new Material
            (
              elevation: 2.0,
              color: card2 ? MyColors.blue : Colors.white,
              child: new Material
              (
                color: Colors.transparent,
                child: new InkWell
                (
                  onTap: ()
                  {
                    setState(() => card2 = !card2);
                    
                    if(card2) User.completedTasks.add(TasksList.tasks[1]);
                    else User.removeTask(TasksList.tasks[1].description);

                    IOManager.saveCompletedTasks();
                  },
                  child: new Container
                  (
                    padding: new EdgeInsets.all(16.0),
                    child: new Column
                    (
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>
                      [
                        /// Emoji text
                        new Row
                        (
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>
                          [
                            /// Task emoji
                            new Flexible
                            (
                              child: new Text(TasksList.tasks[1].emoji, style: new TextStyle(fontSize: 28.0)),
                            ),
                          ],
                        ),
                        new Padding(padding: new EdgeInsets.only(bottom: 16.0)),
                        new Row
                        (
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>
                          [
                            /// Task description
                            new Flexible
                            (
                              child: new Text
                              (
                                TasksList.tasks[1].description.endsWith('.') ?  TasksList.tasks[1].description :  TasksList.tasks[1].description + '.',
                                style: new TextStyle(color: card2 ? Colors.white : Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500)
                              ),
                            ),
                            new Checkbox
                            (
                              onChanged: (bool newState)
                              {
                                setState(() => card2 = newState);
                                
                                if(newState) User.completedTasks.add(TasksList.tasks[1]);
                                else User.removeTask(TasksList.tasks[1].description);

                                IOManager.saveCompletedTasks();
                              },
                              activeColor: MyColors.blue,
                              value: card2,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ),
              )
            ),
          ),
          card1 && card2 ? new Container
          (
            margin: new EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
            child: new RaisedButton
            (
              onPressed: () => Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (_) => new TodoListPage())),
              color: Colors.black,
              child: new ListTile
              (
                title: new Text('Let\'s start', style: new TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                trailing: new Icon(Icons.arrow_forward, color: Colors.white),
              ),
            )
          ) : new Container()
        ],
      ),
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

  saveName(String userName) async
  {
    if(userName.trim().length > 10 || userName.trim().length < 4)
    {
      return;
    }

    User.prefs.setString('userName', userName.trim());
    await User.prefs.commit();

    setState(() => User.name = userName.trim());
    
    if(User.userImagePath != null) pageController.nextPage(duration: new Duration(milliseconds: 500), curve: Curves.easeInOut);
    else showAskImageDialog();
  }

  void showAskImageDialog()
  {
    showDialog
    (
      context: context,
      child: new AlertDialog
      (
        title: new Text("You didn't add a profile image"),
        content: new Text("You are still able to add one afterwards."),
        actions: <Widget>
        [
          new FlatButton
          (
            textColor: Colors.blue,
            onPressed: () { Navigator.pop(context); getImage(); },
            child: new Text("ADD AN IMAGE"),
          ),
          new FlatButton
          (
            textColor: Colors.black54,
            onPressed: () { Navigator.pop(context); pageController.nextPage(duration: new Duration(milliseconds: 500), curve: Curves.easeInOut); },
            child: new Text("CONTINUE"),
          ),
        ],
      )
    );
  }
}