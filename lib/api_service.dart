import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, String>>> fetchTodos() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);

    return data.map((todo) {
      return {
        "title": todo['title'] as String,
        "description": (todo['completed'] as bool) ? 'Completed' : 'Pending',
      };
    }).toList();
  } else {
    throw Exception('Failed to load todos');
  }
}
