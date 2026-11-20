
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TaskListPage(),
    );
  }
}

class Task {
  String title;
  bool isCompleted;

  Task(this.title, this.isCompleted);
}

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {

  List<Task> tasks = [
  Task('Study', false),
  Task('Watch a Movie', false),
  Task('Work on Project', false),
  Task('Go to Gym', false),
];

  @override
  Widget build(BuildContext context) {
    int count = 0;

    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].isCompleted) {
        count++;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('My Tasks')),

      body: Column(
        children: [
          Text('Completed: $count / ${tasks.length}'),

          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return TaskItem(
                  tasks[index].title,
                  tasks[index].isCompleted,
                  (value) {
                    setState(() {
                      tasks[index].isCompleted = value ?? false;
                    });
                  },
                );
              },
            ),
          ),

          ElevatedButton(
            onPressed: () {
              List<Task> completed = [];

              for (int i = 0; i < tasks.length; i++) {
                if (tasks[i].isCompleted) {
                  completed.add(tasks[i]);
                }
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CompletedTasksPage(completed),
                ),
              );
            },
            child: const Text('Completed Tasks'),
          ),
        ],
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final Function(bool?) onChanged;

  const TaskItem(this.title, this.isCompleted, this.onChanged, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Checkbox(
            value: isCompleted,
            onChanged: onChanged,
          ),
          Text(title),
        ],
      ),
    );
  }
}

class CompletedTasksPage extends StatelessWidget {
  final List<Task> completed;

  const CompletedTasksPage(this.completed, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Completed Tasks')),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: completed.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Text(completed[index].title),
                );
              },
            ),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }
}
