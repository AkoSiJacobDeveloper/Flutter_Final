import 'package:flutter/material.dart';

class TodoDataPage extends StatelessWidget {
  final List<Map<String, String>> todos = [
    {"title": "Learn Flutter", "description": "Complete the Flutter tutorial"},
    {"title": "Buy groceries", "description": "Milk, eggs, bread, etc."},
    {"title": "Workout", "description": "Go for a run at 6 PM"},
  ];

  void _deleteTodo(int index) {
    todos.removeAt(index);
  }

  void _editTodo(int index, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController titleController =
            TextEditingController(text: todos[index]['title']);
        TextEditingController descriptionController =
            TextEditingController(text: todos[index]['description']);

        return AlertDialog(
          title: Text('Edit Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                todos[index]['title'] = titleController.text;
                todos[index]['description'] = descriptionController.text;
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo Data Page")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Text(todos[index]['title']!),
                subtitle: Text(todos[index]['description']!),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _editTodo(index, context),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteTodo(index),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
