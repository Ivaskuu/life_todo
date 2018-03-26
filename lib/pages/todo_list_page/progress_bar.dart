import 'package:flutter/material.dart';
import '../../misc/mycolors.dart';
import '../../misc/tasks_list.dart';
import 'todo_list_page.dart';
import '../../user.dart';

class ProgressBar extends StatefulWidget
{
  final TodoListPage listPage;
  ProgressBar(this.listPage);

  @override
  _ProgressBarState createState() => new _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar>
{
  @override
  void dispose()
  {
    widget.listPage.showSmallProgressBar = true;
    widget.listPage.resetState = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    widget.listPage.showSmallProgressBar = false;
    widget.listPage.resetState = true;
    
    return new Container
    (
      padding: new EdgeInsets.only(left: 18.0, right: 18.0, bottom: 20.0),
      child: new Column
      (
        children: <Widget>
        [
          new Row
          (
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>
            [
              new Text('PROGRESS', style: new TextStyle(fontWeight: FontWeight.w500)),
              new Row
              (
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>
                [
                  new Text(User.completedTasks.length.toString(), style: new TextStyle(color: MyColors.blue, fontWeight: FontWeight.w700)),
                  new Text('/'),
                  new Text(TasksList.tasks.length.toString(), style: new TextStyle(fontWeight: FontWeight.w500)),
                ],
              )
            ],
          ),
          new Padding(padding: new EdgeInsets.only(bottom: 8.0)),
          new Stack
          (
            alignment: FractionalOffset.centerLeft,
            children: <Widget>
            [
              new SizedBox.fromSize
              (
                size: new Size.fromHeight(50.0),
                child: new Material
                (
                  color: MyColors.progressBarBackground,
                ),
              ),
              new SizedBox.fromSize
              (
                size: new Size((User.completedTasks.length / TasksList.tasks.length) * MediaQuery.of(context).size.width - (((User.completedTasks.length / TasksList.tasks.length) * MediaQuery.of(context).size.width) * 0.1), 50.0),
                child: new Material
                (
                  color: MyColors.blue,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}