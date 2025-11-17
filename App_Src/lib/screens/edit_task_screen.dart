import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class EditTaskPage extends StatelessWidget {
  final ParseObject task;
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  EditTaskPage({required this.task})
      : titleController = TextEditingController(text: task.get<String>('title')),
        descriptionController = TextEditingController(text: task.get<String>('description'));

  Future<void> updateTask(BuildContext context) async {
    task.set('title', titleController.text);
    task.set('description', descriptionController.text);
    await task.save();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: titleController, decoration: InputDecoration(labelText: 'Title')),
            TextField(controller: descriptionController, decoration: InputDecoration(labelText: 'Description')),
            ElevatedButton(onPressed: () => updateTask(context), child: Text('Save')),
          ],
        ),
      ),
    );
  }
}
