import 'package:flutter/material.dart';
import '../../misc/mycolors.dart';

class ProgressBar extends StatefulWidget
{
  @override
  _ProgressBarState createState() => new _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar>
{
  @override
  Widget build(BuildContext context)
  {
    return new Container
    (
      margin: new EdgeInsets.only(left: 18.0, right: 18.0),
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
                  new Text('29', style: new TextStyle(color: MyColors.blue, fontWeight: FontWeight.w600)),
                  new Text('/'),
                  new Text('66', style: new TextStyle(fontWeight: FontWeight.w500)),
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
                size: new Size(120.0, 50.0),
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