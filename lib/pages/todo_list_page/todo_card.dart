import 'package:flutter/material.dart';
import '../../misc/io_manager.dart';
import '../../misc/mycolors.dart';
import '../../logic/task.dart';
import '../../user.dart';

import 'package:share/share.dart';

class TodoCard extends StatefulWidget
{
  Task task;
  State state;
  TodoCard(this.task, this.state);

  @override
  _TodoCardState createState() => new _TodoCardState();
}

class _TodoCardState extends State<TodoCard>
{
  @override
  Widget build(BuildContext context)
  {
    return new Container
    (
      margin: new EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12.0),
      child: new Material
      (
        elevation: 2.0,
        color: widget.task.done ? MyColors.blue : Colors.white,
        child: new Material
        (
          color: Colors.transparent,
          child: new InkWell
          (
            onTap: ()
            {
              setState(() => widget.task.done = !widget.task.done);
              
              if(widget.task.done) User.completedTasks.add(widget.task);
              else User.removeTask(widget.task.description);

              IOManager.saveCompletedTasks();
              widget.state.setState(() {});
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
                        child: new Text(widget.task.emoji, style: new TextStyle(fontSize: 28.0)),
                      ),
                      // Share button
                      widget.task.done
                      ? new InkWell
                      (
                        onTap: () => share(User.name + ' has completed ' + widget.task.description + ' in his life!\n\nDownload it here: https://play.google.com/store/apps/details?id=com.skuu.lifetodo'),
                        child: new Container
                        (
                          margin: new EdgeInsets.only(right: 12.0),
                          child: new Icon(Icons.share, color: Colors.white, size: 22.0),
                        )
                      )
                      : new Container()
                      /*new Expanded
                      (
                        child: new Container
                        (
                          margin: new EdgeInsets.only(left: 64.0),
                          child: new Stack
                          (
                            children: <Widget>
                            [
                              new Align
                              (
                                alignment: new Alignment(-1.0, 0.0),
                                child: new CircleAvatar(backgroundImage: new AssetImage('res/me.png')),
                              ),
                              new Align
                              (
                                alignment: new Alignment(0.0, 0.0),
                                child: new CircleAvatar(backgroundImage: new AssetImage('res/me.png')),
                              ),
                              new Align
                              (
                                alignment: new Alignment(1.0, 0.0),
                                child: new CircleAvatar(backgroundImage: new AssetImage('res/me.png')),
                              ),
                            ],
                          )
                        ),
                      )*/ // TODO: friends integration
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
                          widget.task.description.endsWith('.') ?  widget.task.description :  widget.task.description + '.',
                          style: new TextStyle(color: widget.task.done ? Colors.white : Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500)
                        ),
                      ),
                      new Checkbox
                      (
                        onChanged: (bool newState)
                        {
                          setState(() => widget.task.done = newState);
                          
                          if(newState) User.completedTasks.add(widget.task);
                          else User.removeTask(widget.task.description);

                          IOManager.saveCompletedTasks();
                          widget.state.setState(() {});
                        },
                        activeColor: MyColors.blue,
                        value: widget.task.done,
                      ),
                    ],
                  )
                ],
              ),
            )
          ),
        )
      ),
    );
  }
}