import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';

class RateDialog extends StatelessWidget
{
  BuildContext buildContext;

  @override
  Widget build(BuildContext context)
  {
    buildContext = context;

    return new AlertDialog
    (
      contentPadding: new EdgeInsets.all(0.0),
      content: new Column
      (
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>
        [
          new Container
          (
            color: Colors.yellow,
            padding: new EdgeInsets.symmetric(vertical: 32.0),
            child: new Center
            (
              child: new Icon(Icons.shop, color: Colors.black, size: 48.0),
            ),
          ),
          new Container
          (
            margin: new EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: new Text('Rate the app?', style: new TextStyle(color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.w700))
          ),
          new Container
          (
            margin: new EdgeInsets.only(left: 16.0, right: 16.0),
            child: new Text('You are one of the first people to download the app, and your feedback is very important.\n\nWould you mind giving it a rating on the Play Store?'),
          ),
          new Container
          (
            margin: new EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0, bottom: 16.0),
            child: new Row
            (
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>
              [
                new Icon(Icons.star_border),
                new Icon(Icons.star_border),
                new Icon(Icons.star_border),
                new Icon(Icons.star_border),
                new Icon(Icons.star_border),
              ],
            ),
          ),
        ],
      ),
      actions: <Widget>
      [
        new FlatButton
        (
          textColor: Colors.black38,
          onPressed: () => Navigator.of(context).pop(),
          child: new Text('NEVER ASK AGAIN'),
        ),
        new FlatButton
        (
          textColor: Colors.blue,
          onPressed: () { LaunchReview.launch(androidAppId: 'com.skuu.lifetodo'); showRatedDialog(); },
          child: new Text('RATE IT'),
        ),
      ],
    );
  }

  void showRatedDialog()
  {
    showDialog
    (
      context: buildContext,
      child: new AlertDialog
      (
        titlePadding: new EdgeInsets.all(0.0),
        title: new Container
        (
          color: Colors.pink,
          padding: new EdgeInsets.symmetric(vertical: 32.0),
          child: new Center
          (
            child: new Icon(Icons.favorite, color: Colors.white, size: 48.0),
          ),
        ),
        content: new Text('Thank you, you are the best.'),
        actions: <Widget>
        [
          new FlatButton
          (
            onPressed: () { Navigator.of(buildContext).pop(); Navigator.of(buildContext).pop(); },
            child: new Text('I AM THE BEST'),
          )
        ],
      )
    );
  }
}