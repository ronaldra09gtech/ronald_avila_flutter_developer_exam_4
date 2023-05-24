import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_provider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => TaskProvider(),
      child: MaterialApp(
        title: 'Flutter CRUD Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final taskController = TextEditingController();

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter CRUD Demo'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: taskController,
              decoration: const InputDecoration(labelText: 'Task'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Provider.of<TaskProvider>(context, listen: false)
                  .addTask(taskController.text);
              taskController.clear();
            },
            child: const Text('Add Task'),
          ),
          Expanded(
            child: Consumer<TaskProvider>(
              builder: (ctx, taskData, _) => ListView.builder(
                itemCount: taskData.tasks.length,
                itemBuilder: (ctx, i) => ListTile(
                  title: Text(taskData.tasks[i].name),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      taskData.deleteTask(taskData.tasks[i].id);
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
