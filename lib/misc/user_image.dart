import 'package:flutter/material.dart';
import '../user.dart';
import 'dart:io';

class UserImage extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return User.userImagePath != null
    ? new Container
    (
      decoration: new BoxDecoration(image: new DecorationImage(image: new FileImage(new File(User.userImagePath)), fit: BoxFit.cover, alignment: Alignment.center))
    ) : new Container(decoration: new BoxDecoration(image: new DecorationImage(image: new AssetImage('res/user.png'), fit: BoxFit.cover, alignment: Alignment.center)));
  }
}