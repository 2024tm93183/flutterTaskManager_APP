

class ParseService {
  Future<void> createTask(String title, String description) async {
    final task = ParseObject('Task')
      ..set('title', title)
      ..set('description', description);
    await task.save();
  }

  Future<void> updateTask(ParseObject task, String title, String description) async {
    task.set('title', title);
    task.set('description', description);
    await task.save();
  }

  Future<void> deleteTask(ParseObject task) async {
    await task.delete();
  }
}

