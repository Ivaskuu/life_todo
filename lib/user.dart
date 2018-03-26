import 'logic/task.dart';

class User
{
  static String name = 'Francesco';
  static List<Task> completedTasks = new List();

  static void removeTask(String taskDesc)
  {
    for(int i = 0; i < completedTasks.length; i++)
    {
      if(completedTasks[i].description == taskDesc) completedTasks.removeAt(i);
    }
  }
}