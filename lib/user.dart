import 'logic/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User
{
  static String name;
  static String userImagePath;
  static List<Task> completedTasks = new List();
  static bool hasShownRateDialog;

  static SharedPreferences prefs;

  static void removeTask(String taskDesc)
  {
    for(int i = 0; i < completedTasks.length; i++)
    {
      if(completedTasks[i].description == taskDesc) completedTasks.removeAt(i);
    }
  }
}