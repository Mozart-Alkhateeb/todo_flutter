import 'package:flutter/material.dart';

// Import Our home screen
import './screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ToDo',
      home: HomeScreen(), // The Home screen widget as app home page
    );
  }
}
