import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile-image.jpg'), // Update this path to an actual image in your assets folder
            ),
            SizedBox(height: 20),
            Text(
              "John Doe", // Replace with dynamic data if needed
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Flutter Developer", style: TextStyle(fontSize: 18)),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to HomePage
              },
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
