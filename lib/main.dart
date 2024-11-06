import 'package:flutter/material.dart';

void main() {
  runApp(ToDoApp());
}

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: ToDoHomePage(),
    );
  }
}

class ToDoHomePage extends StatefulWidget {
  @override
  _ToDoHomePageState createState() => _ToDoHomePageState();
}

class _ToDoHomePageState extends State<ToDoHomePage> {
  List<Map<String, dynamic>> toDoList = [
    {'task': 'Learn Flutter', 'completed': false},
    {'task': 'Build a To-Do App', 'completed': false},
  ];

  final TextEditingController taskController = TextEditingController();

  void addTask(String task) {
    setState(() {
      toDoList.add({'task': task, 'completed': false});
    });
    taskController.clear();
  }

  void toggleTaskCompletion(int index) {
    setState(() {
      toDoList[index]['completed'] = !toDoList[index]['completed'];
    });
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple To-Do List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      labelText: 'Add a new task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (taskController.text.isNotEmpty) {
                      addTask(taskController.text);
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: toDoList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    toDoList[index]['task'],
                    style: TextStyle(
                      decoration: toDoList[index]['completed']
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  leading: Checkbox(
                    value: toDoList[index]['completed'],
                    onChanged: (value) {
                      toggleTaskCompletion(index);
                    },
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteTask(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
