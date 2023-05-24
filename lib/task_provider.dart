import 'package:flutter/material.dart';
import 'task.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks {
    return [..._tasks];
  }

  void addTask(String taskName) {
    final newTask = Task(id: DateTime.now().toString(), name: taskName);
    _tasks.add(newTask);
    notifyListeners();
  }

  void deleteTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }

  void updateTask(String taskId, String newTaskName) {
    final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
    if (taskIndex >= 0) {
      _tasks[taskIndex].name = newTaskName;
      notifyListeners();
    }
  }
}
