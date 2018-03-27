import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'tasks_list.dart';
import '../logic/task.dart';
import '../user.dart';

class IOManager
{
  static Future<String> get _localPath async
  {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _getSaveFile async
  {
    final path = await _localPath;
    return new File('$path/completed_tasks.txt');
  }

  static Future<void> getCompletedTasks() async
  {
    List<Task> completedTasks = new List();

    try
    {
      File file = await _getSaveFile;
      List<String> contents = await file.readAsLines();

      for (int i = 0; i < contents.length; i++)
      {
        for (int j = 0; j < TasksList.tasks.length; j++)
        {
          if(contents[i] == TasksList.tasks[j].description)
          {
            completedTasks.add(TasksList.tasks[j]);
          }
        }
      }

      User.completedTasks = completedTasks;
    }
    catch (e)
    {
      print(e);
      return completedTasks;
    }
  }

  static void saveCompletedTasks() async
  {
    File file = await _getSaveFile;
    String tasksToWrite = '';

    List<Task> tasks = User.completedTasks;

    for (int i = 0; i < tasks.length; i++)
    {
      tasksToWrite += tasks[i].description;
      if(i != tasks.length - 1) tasksToWrite += '\n';
    }

    print(tasksToWrite);
    file.writeAsString(tasksToWrite, mode: FileMode.WRITE_ONLY);
  }
}