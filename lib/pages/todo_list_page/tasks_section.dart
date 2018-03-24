import 'package:flutter/material.dart';
import '../../logic/task.dart';
import '../../misc/tasks_list.dart';
import 'todo_card.dart';

class TasksSection extends StatefulWidget
{
  @override
  _TasksSectionState createState() => new _TasksSectionState();
}

class _TasksSectionState extends State<TasksSection>
{
  @override
  Widget build(BuildContext context)
  {
    return new Column
    (
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: TasksList.tasks.map<Widget>((Task task) => new TodoCard(task)).toList()
    );
  }
}