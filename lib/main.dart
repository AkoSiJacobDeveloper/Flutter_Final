import 'package:flutter/material.dart';
import 'home_page.dart'; // Import HomePage
import 'profile_page.dart'; // Import ProfilePage
import 'todo_data_page.dart'; // Import TodoDataPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation',
      initialRoute: '/', 
      routes: {
        '/': (context) => HomePage(),  
        '/profile': (context) => ProfilePage(),  
        '/todoData': (context) => TodoDataPage(), 
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
