import 'package:flutter/material.dart';
import '../../logic/task.dart';
import '../../misc/tasks_list.dart';
import '../../user.dart';
import 'todo_card.dart';

class TasksSection extends StatefulWidget
{
  State state;
  TasksSection(this.state);

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
      children: TasksList.tasks.map<Widget>((Task task) => new TodoCard(checkIfDone(task), widget.state)).toList()
    );
  }

  Task checkIfDone(Task task)
  {
    for (var i = 0; i < User.completedTasks.length; i++)
    {
      if(User.completedTasks[i].description == task.description)
      {
        task.done = true;
        break;
      }
    }

    return task;
  }
}