import 'package:flutter/material.dart';
import '../../misc/mycolors.dart';
import '../../misc/io_manager.dart';

import 'progress_bar.dart';
import 'tasks_section.dart';

class TodoListPage extends StatefulWidget
{
  bool showSmallProgressBar = false;
  bool resetState = false;

  @override
  TodoListPageState createState() => new TodoListPageState();
}

class TodoListPageState extends State<TodoListPage>
{
  ScrollController controller = new ScrollController();

  @override
  void initState()
  {
    super.initState();

    IOManager.getCompletedTasks().then((_) => setState(() {}));

    controller.addListener(()
    {
      if(widget.resetState)
      {
        setState(() {});
        widget.resetState = false;
      }
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return new Scaffold
    (
      backgroundColor: new Color(0xEEFFFFFF),
      body: new CustomScrollView
      (
        controller: controller,
        scrollDirection: Axis.vertical,
        slivers: <Widget>
        [
          new SliverAppBar
          (
            elevation: 3.0,
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: false,
            backgroundColor: Colors.white,
            titleSpacing: 0.0,
            title: new Stack
            (
              children: <Widget>
              [
                new Align
                (
                  alignment: FractionalOffset.centerLeft,
                  child: new Container
                  (
                    margin: new EdgeInsets.only(left: 16.0),
                    child: new Text('Life story', style: new TextStyle(color: Colors.black, fontSize: 32.0, fontWeight: FontWeight.w600))
                  ),
                ),
                new Align
                (
                  alignment: FractionalOffset.centerRight,
                  child: new Container
                  (
                    margin: new EdgeInsets.only(right: 16.0),
                    child: new Material
                    (
                      elevation: 0.0,
                      shape: new CircleBorder(),
                      child: new CircleAvatar
                      (
                        radius: 22.0,
                        backgroundColor: Colors.white,
                        backgroundImage: new AssetImage('res/me.jpg'),
                      ),
                    )
                  ),
                ),
                widget.showSmallProgressBar ? new Align
                (
                  alignment: FractionalOffset.bottomLeft,
                  child: new SizedBox.fromSize
                  (
                    size: new Size(MediaQuery.of(context).size.width / 2.0, 4.0),
                    child: new Container(color: MyColors.blue),
                  )
                ) : new Container(),
              ],
            ),
            expandedHeight: 170.0,
            flexibleSpace: new FlexibleSpaceBar
            (
              background: new Column
              (
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[ new ProgressBar(widget) ],
              ),
            ),
          ),
          new SliverList
          (
            delegate: new SliverChildListDelegate
            (
              <Widget>
              [
                new Container
                (
                  margin: new EdgeInsets.only(right: 18.0, bottom: 8.0, top: 16.0),
                  child: new Text('Tasks list', textAlign: TextAlign.end, style: new TextStyle(fontWeight: FontWeight.w500)),
                ),
                new TasksSection()
              ]
            )
          )
        ],
      )
    );
  }
}