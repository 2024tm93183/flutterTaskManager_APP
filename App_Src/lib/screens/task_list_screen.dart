import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'edit_task_screen.dart';

class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  List<ParseObject> tasks = [];

  Future<void> fetchTasks() async {
    final query = QueryBuilder<ParseObject>(ParseObject('Task'));
    final response = await query.query();
    if (response.success && response.results != null) {
      setState(() {
        tasks = response.results as List<ParseObject>;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tasks')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.get<String>('title') ?? 'No Title'),
            subtitle: Text(task.get<String>('description') ?? ''),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => EditTaskPage(task: task))),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = ParseObject('Task')
            ..set('title', 'New Task')
            ..set('description', 'Description');
          await newTask.save();
          fetchTasks();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
