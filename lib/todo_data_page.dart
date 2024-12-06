import 'package:flutter/material.dart';
import 'api_service.dart';
import 'profile_page.dart'; // Import the ProfilePage

class TodoDataPage extends StatefulWidget {
  @override
  _TodoDataPageState createState() => _TodoDataPageState();
}

class _TodoDataPageState extends State<TodoDataPage> {
  late Future<List<Map<String, String>>> todos;

  final List<Color> _colors = [
    Colors.red.shade100,
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.orange.shade100,
    Colors.purple.shade100,
    Colors.yellow.shade100,
  ];

  @override
  void initState() {
    super.initState();
    todos = fetchTodos(); // Fetch todos when the page loads
  }

  // Edit Todo function
  void _editTodo(int index, BuildContext context, List<Map<String, String>> todoList) {
    TextEditingController titleController = TextEditingController(text: todoList[index]['title']);
    TextEditingController descriptionController = TextEditingController(text: todoList[index]['description']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
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
                setState(() {
                  todoList[index]['title'] = titleController.text;
                  todoList[index]['description'] = descriptionController.text;
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Delete Todo function
  void _deleteTodo(int index, List<Map<String, String>> todoList) {
    setState(() {
      todoList.removeAt(index); // Remove todo from the list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Data Page"),
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: todos, // Get the todos from the API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Todos found'));
          } else {
            List<Map<String, String>> todoList = snapshot.data!;

            return Column(
              children: [
                // Profile link/button above the todos
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to ProfilePage
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                    child: Text("Go to Profile Page"),
                  ),
                ),
                // List of Todos
                Expanded(
                  child: ListView.builder(
                    itemCount: todoList.length,
                    itemBuilder: (context, index) {
                      var todo = todoList[index];
                      Color color = _colors[index % _colors.length];

                      return Card(
                        margin: EdgeInsets.all(10),
                        child: Container(
                          color: color,
                          child: ListTile(
                            title: Text(todo['title']!),
                            subtitle: Text(todo['description']!),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () => _editTodo(index, context, todoList),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () => _deleteTodo(index, todoList),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
